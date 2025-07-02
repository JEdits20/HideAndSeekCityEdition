import 'package:hide_and_seek_city_edition/services/multiplayer_service.dart';

import '../result.dart';

class LobbyRepository {
  LobbyRepository({
    required ApiService apiClient,
  }) : _apiClient = apiClient;

  final ApiService _apiClient;
  List<String>? _cachedUsernames;

  Future<Result<String>> getUsernames() async {
    // either return cached usernames or
  }

  Future<Result<String>> createLobby(String gameName, String password) async {
    // reset cachedUsernames
  }

}