import 'package:hide_and_seek_city_edition/crypto.dart';
import 'package:hide_and_seek_city_edition/services/multiplayer_service.dart';

import '../result.dart';

class LobbyRepository {
  LobbyRepository({required ApiService apiClient}) : _apiClient = apiClient;

  final ApiService _apiClient;
  List<String>? _cachedUsernames;

  Future<Result<String>> getUsernames() async {
    // either return cached usernames or
  }

  Future<void> createLobby(String gameName, String password) async {
    // reset cachedUsernames
    _apiClient.crypto = GameCrypto(password);
    String encryptedValidationData = _apiClient.crypto!.encryptString(
      "This is the wonderful test data, that should always be valid.",
    );
    try {
      await _apiClient.newLobby(gameName, encryptedValidationData);
    } catch (e) {
      throw FormatException('Failed to create Lobby', e);
    }
    // handle result
  }
}
