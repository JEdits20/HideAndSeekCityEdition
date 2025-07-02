import 'dart:convert';

import 'package:hide_and_seek_city_edition/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../result.dart';

class ApiService {
  final String baseUrl;
  GameCrypto? crypto;

  late final WebSocketChannel channel;

  ApiService(this.baseUrl, String ip, port) {
    // substitute your server's IP and port
    final wsUrl = 'ws://$ip:$port';
    channel = WebSocketChannel.connect(Uri.parse(wsUrl));
  }

  Future<Result<void>> newLobby(String gameName, String encryptedValidationData) async {
    // TODO: http endpoint to create new lobby
    return Result.ok(());
  }

  /// Returns encrypted json map of locations.
  Future<Result<String>> getLocations(String gameName) async {
    // TODO: http endpoint to get locations
    return Result.ok("TODO");
  }

  /// Returns encrypted json list of usernames.
  Future<Result<String>> getUsernames(String gameName) async {
    // TODO: http endpoint to get usernames
    return Result.ok("TODO");
  }

  Future<void> setName(String name) async {
    sendData({'name': name}, "create");
  }

  Future<Map<String, dynamic>> sendData(Map<String, dynamic> data, String endpoint) async {
    int maxRetries = 3;
    http.Response? response;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        response = await http.post(
          Uri.parse('$baseUrl/$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
        if (response.statusCode == 200) {
          print('Data sent successfully: ${response.body}');
          return jsonDecode(response.body);
        } else {
          print('Failed to send data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred while sending data: $e');
      } finally {
        if (attempt < maxRetries - 1) {
          await Future.delayed(Duration(seconds: 2));
        }
      }
    }
    if (response == null) return {'status': "error trying to reach the server"};
    if (response.body.isEmpty) return {'status': response.statusCode};
    return jsonDecode(response.body);
  }
}
