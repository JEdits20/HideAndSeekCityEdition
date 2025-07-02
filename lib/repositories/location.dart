import 'dart:collection';

import 'package:hide_and_seek_city_edition/domain%20models%20aka%20objects/location_info.dart';
import 'package:hide_and_seek_city_edition/services/multiplayer_service.dart';

import '../result.dart';

class LocationRepository {
  LocationRepository({required ApiService apiClient}) : _apiClient = apiClient;

  final ApiService _apiClient;
  List<String>? _cachedLocations;

  Future<Result<HashMap<String, LocationInfo>>> getLocations(String gameName) async {
    if (_apiClient.crypto == null)
      return Result.error(Exception("getLocations() was called before a game('s crypto instance) was initialized"));
    final res = await _apiClient.getLocations(gameName);
    switch (res) {
      case Err<String>():
        return Result.error(res.error);
      case Ok<String>():
    }
    final HashMap<String, LocationInfo> locations = _apiClient.crypto!.decryptJSON(res.value);
    return Result.ok(locations);
    // either return cached locations or fetch new ones based on connection state
  }
}
