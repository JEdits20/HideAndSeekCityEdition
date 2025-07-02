import 'package:hide_and_seek_city_edition/crypto.dart';
import 'package:hide_and_seek_city_edition/services/multiplayer_service.dart';

import '../result.dart';

class LobbyRepository {
  LobbyRepository({required ApiService apiClient}) : _apiClient = apiClient;

  final ApiService _apiClient;
  List<String>? _cachedUsernames;
  String? gameName;

  Future<Result<List<String>>> getUsernames() async {
    if (_apiClient.crypto == null)
      return Result.error(
        Exception(
          "getUsernames() was called before a game('s crypto instance) was initialized",
        ),
      );
    if (gameName == null)
      return Result.error(
        Exception("getUsernames() was called before a game was initialized"),
      );
    final res = await _apiClient.getUsernames(gameName!);
    switch (res) {
      case Err<String>():
        return Result.error(res.error);
      case Ok<String>():
    }
    final List<String> usernames = _apiClient.crypto!.decryptJSON(res.value);
    return Result.ok(usernames);
  }

  Future<Result<void>> createLobby(String gameName, String password) async {
    // reset cachedUsernames
    this.gameName = gameName;
    _apiClient.crypto = GameCrypto(password);
    String encryptedValidationData = _apiClient.crypto!.encryptString(
      "This is the wonderful test data, that should always be valid.",
    );
    try {
      return await _apiClient.newLobby(gameName, encryptedValidationData);
    } on Exception catch (e) {
      return Result.error(e);
    }
    // handle result
  }
}
