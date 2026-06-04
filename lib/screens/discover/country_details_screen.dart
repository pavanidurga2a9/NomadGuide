import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../providers/favorites_provider.dart';
import '../../models/country_model.dart';
import '../map/destination_map_screen.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final isFav = favoritesProvider.isFavorite(country.name);
          return FloatingActionButton(
            onPressed: () {
              favoritesProvider.toggleFavorite(country);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFav
                        ? '${country.name} removed from favorites'
                        : '${country.name} added to favorites',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
          );
        },
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(country.name),
              background: CachedNetworkImage(
                imageUrl: country.flagUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      context,
                      Icons.location_city,
                      'Capital',
                      country.capital.join(', '),
                    ),
                    _buildInfoRow(
                      context,
                      Icons.people,
                      'Population',
                      country.population.toString(),
                    ),
                    _buildInfoRow(
                      context,
                      Icons.language,
                      'Languages',
                      country.languages.values.join(', '),
                    ),
                    _buildInfoRow(
                      context,
                      Icons.attach_money,
                      'Currency',
                      country.currency,
                    ),
                    _buildInfoRow(
                      context,
                      Icons.public,
                      'Region',
                      '${country.region}, ${country.subregion}',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Location & Nearby Hotels',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                              country.latlng[0],
                              country.latlng[1],
                            ),
                            initialZoom: 12.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.nomad_guide',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(
                                    country.latlng[0],
                                    country.latlng[1],
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                                // Mock Nearby Hotels
                                Marker(
                                  point: LatLng(
                                    country.latlng[0] + 0.01,
                                    country.latlng[1] + 0.01,
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Tooltip(
                                    message: "Luxury Hotel",
                                    child: Icon(
                                      Icons.hotel,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Marker(
                                  point: LatLng(
                                    country.latlng[0] - 0.01,
                                    country.latlng[1] + 0.02,
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Tooltip(
                                    message: "City Inn",
                                    child: Icon(
                                      Icons.hotel,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                Marker(
                                  point: LatLng(
                                    country.latlng[0] + 0.02,
                                    country.latlng[1] - 0.01,
                                  ),
                                  width: 40,
                                  height: 40,
                                  child: const Tooltip(
                                    message: "Backpacker Hostel",
                                    child: Icon(
                                      Icons.hotel,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DestinationMapScreen(country: country),
                            ),
                          );
                        },
                        icon: const Icon(Icons.map),
                        label: const Text('View Full Map & Nearby Hotels'),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
