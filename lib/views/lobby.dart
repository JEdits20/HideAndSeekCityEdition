import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(HideAndSeekApp());
}

class HideAndSeekApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hide and Seek: City Edition',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LobbyScreen(),
    );
  }
}

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isUsernameValid = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _isUsernameValid = _usernameController.text.length >= 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: FlutterMap(
              options: MapOptions(initialCenter: LatLng(52.270088, 10.363668), initialZoom: 13.0),
              children: [TileLayer(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username input field with a pen icon
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.white, // Pen icon color
                              ),
                              hintText: 'Username',
                              hintStyle: TextStyle(color: Colors.white54),
                            ),
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 36, // Increased size (1.5 times)
                              shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 8)],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (_isUsernameValid) ...[
                  GestureDetector(
                    onTap: () {
                      // Host game logic here
                    },
                    child: Text(
                      'Host Game',
                      style: TextStyle(
                        color: Colors.white, // High contrast text color
                        fontSize: 36, // Increased size (1.5 times)
                        shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 8)],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Join game logic here
                    },
                    child: Text(
                      'Join Game',
                      style: TextStyle(
                        color: Colors.white, // High contrast text color
                        fontSize: 36,
                        shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 8)],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
