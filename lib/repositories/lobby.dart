import 'dart:developer';

import 'package:hide_and_seek_city_edition/crypto.dart';
import 'package:hide_and_seek_city_edition/services/multiplayer_service.dart';

import '../result.dart';

class LobbyRepository {
  LobbyRepository({required ApiService apiClient}) : _apiClient = apiClient;

  final ApiService _apiClient;
  List<String>? _cachedUsernames;
  Map<String, String>? _cachedLobbies;
  String? lobbyName;

  Future<Result<List<String>>> getUsernames() async {
    if (_apiClient.crypto == null)
      return Result.error(Exception("getUsernames() was called before a game('s crypto instance) was initialized"));
    if (lobbyName == null) return Result.error(Exception("getUsernames() was called before a game was initialized"));
    final res = await _apiClient.getUsernames(lobbyName!);
    switch (res) {
      case Err<List<String>>():
        return Result.error(res.error);
      case Ok<List<String>>():
    }
    final List<String> usernames = [];
    final List<String> encryptedValues = res.value;
    // check each username entry for valid lobbyName
    for (var encryptedValue in encryptedValues) {
      // each username entry is encrypted separately
      final namePlusLobby = _apiClient.crypto!.decryptJSON(encryptedValue);
      if (!namePlusLobby.endsWith(lobbyName!)) {
        log("A shady person was detected in this lobby! Name: $namePlusLobby Lobby: ${lobbyName!}");
        continue;
      }
      // truncate the username
      usernames.add(namePlusLobby.substring(0, namePlusLobby.length - lobbyName!.length));
    }
    _cachedUsernames = usernames;
    return Result.ok(usernames);
  }

  static const testData = "This is the wonderful test data, that should always be valid.";

  Future<Result<void>> createLobby(String lobbyName, String password) async {
    // reset cachedUsernames
    this.lobbyName = lobbyName;
    _apiClient.crypto = GameCrypto(password);
    String encryptedValidationData = _apiClient.crypto!.encryptString(testData);
    try {
      return await _apiClient.newLobby(lobbyName, encryptedValidationData);
    } on Exception catch (e) {
      return Result.error(e);
    }
    // handle result
  }

  /// Returns false, when wrong password is used
  Future<Result<bool>> joinLobby(String lobbyName, String password, String username) async {
    //if (_cachedLobbies == null) return Result.error(Exception("joinLobby() was called before lobbies were cached"));
    assert(_cachedLobbies != null);
    // reset cachedUsernames
    this.lobbyName = lobbyName;
    _apiClient.crypto = GameCrypto(password);

    final encryptedTestData = _cachedLobbies![lobbyName];
    assert(encryptedTestData != null);
    String encryptedValidationData = _apiClient.crypto!.decryptString(encryptedTestData!);
    if (encryptedValidationData != testData)
      return Result.error(Exception("Wrong password used!")); // TODO: create own exceptions for wrong password

    // the username is concatenated with the lobbyName that all clients are sure this is someone who knows the password (or is a copycat)
    // integrity!
    final encryptedUsername = _apiClient.crypto!.encryptString(username + lobbyName);

    try {
      await _apiClient.joinLobby(lobbyName, encryptedUsername);
    } on Exception catch (e) {
      return Result.error(e);
    }
    return Result.ok(true);
  }

  Future<Result<List<String>>> getLobbyNames() async {
    final res = await _apiClient.getLobbies();
    switch (res) {
      case Err<Map<String, String>>():
        return Result.error(res.error);
      case Ok<Map<String, String>>():
    }
    final lobbies = res.value;
    _cachedLobbies = lobbies;
    return Result.ok(lobbies.keys.toList(growable: false));
  }
}
