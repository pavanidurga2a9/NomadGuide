import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('World Map')),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(20.0, 0.0), // Center of world approximately
          initialZoom: 2.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.nomad_guide',
          ),
          // Add markers here if needed in future
        ],
      ),
    );
  }
}
