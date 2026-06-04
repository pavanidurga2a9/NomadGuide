import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../models/country_model.dart';

class DestinationMapScreen extends StatelessWidget {
  final Country country;

  const DestinationMapScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${country.name} Map')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(country.latlng[0], country.latlng[1]),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.nomad_guide',
          ),
          MarkerLayer(
            markers: [
              // Main Destination Marker
              Marker(
                point: LatLng(country.latlng[0], country.latlng[1]),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
              ),
              // Mock Nearby Hotels
              _buildHotelMarker(
                country.latlng[0] + 0.01,
                country.latlng[1] + 0.01,
                'Luxury Hotel',
              ),
              _buildHotelMarker(
                country.latlng[0] - 0.01,
                country.latlng[1] + 0.02,
                'City Inn',
              ),
              _buildHotelMarker(
                country.latlng[0] + 0.02,
                country.latlng[1] - 0.01,
                'Backpacker Hostel',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Marker _buildHotelMarker(double lat, double lng, String name) {
    return Marker(
      point: LatLng(lat, lng),
      width: 40,
      height: 40,
      child: Tooltip(
        message: name,
        child: const Icon(Icons.hotel, color: Colors.blue, size: 30),
      ),
    );
  }
}
