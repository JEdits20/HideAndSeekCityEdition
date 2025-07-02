import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class GameModel {
  final String baseUrl;
  DateTime? _gameStartTime;
  List<String> _expectedUpdates = [];
  List<Map<String, dynamic>> _latLngUpdates = [];
  String? _gameName;
  String? _gamePassword;
  int? _pingInterval; // x: ping interval in minutes
  int? _sendWindow; // y: send window in seconds

  GameModel(this.baseUrl);

  // Method to generate a random password
  String _generatePassword(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  // Initialize the game with a name and generate a password
  void initializeGame(String name) {
    _gameName = name;
    _gamePassword = _generatePassword(8); // Generate a random password of length 8
  }

  // Start the game with the given parameters
  Future<void> startGame(String timestamp, int pingInterval, int sendWindow) async {
    _pingInterval = pingInterval;
    _sendWindow = sendWindow;

    final response = await http.post(
      Uri.parse('$baseUrl/start'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{
        'timestamp': timestamp,
        'x': pingInterval,
        'y': sendWindow,
        'name': _gameName, // Include the game name
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _gameStartTime = DateTime.parse(data['timestamp']);
      _expectedUpdates = List<String>.from(data['expectedUpdates']);
    } else {
      throw Exception('Failed to start game: ${response.body}');
    }
  }

  // Getters for relevant variables
  DateTime? get gameStartTime => _gameStartTime;

  List<String> get expectedUpdates => _expectedUpdates;

  List<Map<String, dynamic>> get latLngUpdates => _latLngUpdates;

  String? get gameName => _gameName;

  String? get gamePassword => _gamePassword;

  int? get pingInterval => _pingInterval; // Getter for ping interval
  int? get sendWindow => _sendWindow; // Getter for send window

  // Other methods for sending location updates and fetching updates
  Future<void> sendLocationUpdate(double lat, double lng) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, dynamic>{'lat': lat, 'lng': lng}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _latLngUpdates.add({'lat': data['lat'], 'lng': data['lng'], 'timestamp': DateTime.now()});
    } else {
      throw Exception('Failed to send location update: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> fetchUpdate() async {
    final response = await http.get(Uri.parse('$baseUrl/update'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch update: ${response.body}');
    }
  }

  Future<DateTime?> getStartTime() async {
    final response = await http.get(Uri.parse('$baseUrl/timestart'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DateTime.parse(data['timestamp']);
    } else {
      throw Exception('Failed to get start time: ${response.body}');
    }
  }
}
