import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Start the game
  Future<Map<String, dynamic>> startGame(String timestamp, int x, int y) async {
    final response = await http.post(
      Uri.parse('$baseUrl/start'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'timestamp': timestamp,
        'x': x,
        'y': y,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to start game: ${response.body}');
    }
  }

  // Send location update
  Future<Map<String, dynamic>> sendLocationUpdate(double lat, double lng) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'lat': lat,
        'lng': lng,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send location update: ${response.body}');
    }
  }

  // Fetch updates
  Future<Map<String, dynamic>> fetchUpdate() async {
    final response = await http.get(Uri.parse('$baseUrl/update'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch update: ${response.body}');
    }
  }

  // Get game start time
  Future<Map<String, dynamic>> getStartTime() async {
    final response = await http.get(Uri.parse('$baseUrl/timestart'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get start time: ${response.body}');
    }
  }
}
