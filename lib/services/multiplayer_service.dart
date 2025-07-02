import 'dart:convert';
import 'dart:ffi';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiService {
  bool gameOngoing = false;
  final String baseUrl;
  late Int code;
  late Int uuid;
  String gameKey = 'hllhmnuklahmuklagvrhmuklsrgvloac';

  late final WebSocketChannel channel;

  ApiService(this.baseUrl, String ip, port) {
    // substitute your server's IP and port
    final wsUrl = 'ws://$ip:$port';
    channel = WebSocketChannel.connect(Uri.parse(wsUrl));
  }

  Future<String> newLobby(String gameName, ) async {

  }

  Future<void> setName(String name) async {
    sendData({
      'name': name
    }, "create");
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
      }finally{
        if (attempt < maxRetries - 1) {
          await Future.delayed(Duration(seconds: 2));
        }
      }
    }
    if(response == null) return {'status': "error trying to reach the server"};
    if(response.body.isEmpty) return {'status': response.statusCode};
    return jsonDecode(response.body);
  }

  Future<bool> sendDataEncrypted(Map<String, double> data, String endpoint) async {
    if(!gameOngoing) return false;
    final encryptedValues = encrypt(data.values.toList(growable: false));

    final payload = {
      'values': encryptedValues,
      'code': code,
      'uuid': uuid,
    };

    sendData(payload, endpoint);
    return true;
  }

}
