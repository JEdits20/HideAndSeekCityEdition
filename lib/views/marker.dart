import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapLayers extends StatelessWidget {
  final LatLng centerPoint;
  final double radius;

  MapLayers({required this.centerPoint, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TileLayer(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
        MarkerLayer(markers: [Marker(point: centerPoint, child: Icon(Icons.location_on, color: Colors.red, size: 40))]),
        CircleLayer(
          circles: [
            CircleMarker(
              point: centerPoint,
              useRadiusInMeter: true,
              color: Colors.blue.withAlpha(77),
              borderStrokeWidth: 2,
              borderColor: Colors.blue,
              radius: radius * 1000, // Convert km to meters
            ),
          ],
        ),
      ],
    );
  }
}
