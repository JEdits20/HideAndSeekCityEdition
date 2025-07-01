import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _radius = 1.0;
  LatLng _centerPoint = LatLng(52.270088, 10.363668);
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Handle permission denied case
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OpenStreetMap Example')),
      body: Column(
          children: [
      Expanded(
      child: FlutterMap(
        options: MapOptions(
          initialCenter: _centerPoint, // Set your initial position
          initialZoom: 14.0,
          initialRotation: 0.0,
          interactionOptions: InteractionOptions(
              rotationThreshold: 0,
            rotationWinGestures: InteractiveFlag.none
          ),
          onPositionChanged: (position, hasGesture) {
            // Update the center point when the map is moved
            setState(() {
              _centerPoint = position.center; // Update the center point
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          if (_currentLocation != null) // Show current location marker if available
            MarkerLayer(
              markers: [
                Marker(
                  point: _currentLocation!,
                  child: Icon(Icons.location_on, color: Colors.red, size: 40),
                ),
              ],
            ),
          CircleLayer(
            circles: [
              CircleMarker(
                point: _centerPoint,
                useRadiusInMeter: true,
                color: Colors.blue.withAlpha(77),
                borderStrokeWidth: 2,
                borderColor: Colors.blue,
                radius: _radius * 1000, // Convert km to meters
              ),
            ],
          ),
        ],
      ),
    ),
            Slider(
              value: _radius,
              min: 0.2,
              max: 2.0,
              divisions: 18,
              label: "${_radius.toStringAsFixed(1)} km",
              onChanged: (value) {
                setState(() {
                  _radius = value; // Update the radius
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Radius: ${_radius.toStringAsFixed(1)} km"),
            ),
          ],
      ),
    );
  }
}
