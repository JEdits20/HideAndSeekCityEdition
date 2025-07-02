import 'package:flutter/material.dart';

import 'game/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MapScreen(), // Set MapScreen as the home widget
    );
  }
}
