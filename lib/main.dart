import 'package:flutter/material.dart';
import 'package:link3app/homepage.dart';
 // For charts

void main() => runApp(SensorTrackingApp());

class SensorTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Tracking',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


