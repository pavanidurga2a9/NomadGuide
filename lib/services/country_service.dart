import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';

class CountryService {
  // We are converting this to an "India Tourism" service
  // providing top destinations in India.

  Future<List<Country>> getAllCountries() async {
    // Return a hardcoded list of top Indian destinations
    // We reuse the 'Country' model to avoid breaking the UI
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network

    return [
      _createDestination(
        name: 'India',
        capital: 'New Delhi',
        region: 'South Asia',
        population: 1400000000,
        flag: 'https://flagcdn.com/w640/in.png',
        lat: 20.5937,
        lng: 78.9629,
        desc: 'A land of spirituality, spices, and spectacular sights.',
      ),
      _createDestination(
        name: 'Goa',
        capital: 'Panaji',
        region: 'West India',
        population: 1500000,
        flag:
            'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=640', // Using generic beach image
        lat: 15.2993,
        lng: 74.1240,
        desc: 'Famous for its beaches, nightlife, and Portuguese heritage.',
      ),
      _createDestination(
        name: 'Rajasthan',
        capital: 'Jaipur',
        region: 'North India',
        population: 68000000,
        flag:
            'https://images.unsplash.com/photo-1477587458883-47145ed94245?w=640',
        lat: 27.0238,
        lng: 74.2179,
        desc: 'The Land of Kings, known for palaces, forts, and deserts.',
      ),
      _createDestination(
        name: 'Kerala',
        capital: 'Thiruvananthapuram',
        region: 'South India',
        population: 35000000,
        flag:
            'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=640',
        lat: 10.8505,
        lng: 76.2711,
        desc: 'God\'s Own Country, famous for backwaters and greenery.',
      ),
      _createDestination(
        name: 'Himachal Pradesh',
        capital: 'Shimla',
        region: 'North India',
        population: 7000000,
        flag:
            'https://images.unsplash.com/photo-1626621341120-20d71bd94406?w=640',
        lat: 31.1048,
        lng: 77.1734,
        desc: 'A scenic state in the Himalayas, perfect for trekking.',
      ),
      _createDestination(
        name: 'Varanasi',
        capital: 'Uttar Pradesh',
        region: 'North India',
        population: 1200000,
        flag: 'https://images.unsplash.com/photo-1561361513-35e6e9b98c7f?w=640',
        lat: 25.3176,
        lng: 82.9739,
        desc:
            'The spiritual capital of India, situated on the banks of the Ganges.',
      ),
    ];
  }

  // Helper to create manual Country objects
  Country _createDestination({
    required String name,
    required String capital,
    required String region,
    required int population,
    required String flag,
    required double lat,
    required double lng,
    required String desc,
  }) {
    // We construct the Country object manually consistent with the existing model
    return Country(
      name: name,
      officialName: desc, // Using official name for description
      flagUrl: flag,
      region: region,
      subregion: 'India',
      population: population,
      capital: [capital], // Wrap in list
      languages: {'en': 'English', 'hi': 'Hindi'},
      currency: 'Indian Rupee',
      latlng: [lat, lng],
    );
  }

  // Search for places in India using OpenStreetMap (Nominatim)
  Future<List<Country>> searchPlaces(String query) async {
    if (query.isEmpty) return getAllCountries();

    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&countrycodes=in&format=json&addressdetails=1&limit=10',
      );

      // Nominatim requires a User-Agent
      final response = await http.get(
        url,
        headers: {'User-Agent': 'NomadGuide_StudentApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => _mapNominatimToCountry(item)).toList();
      }
    } catch (e) {
      // debugPrint('Search Error: $e');
    }
    return [];
  }

  Country _mapNominatimToCountry(Map<String, dynamic> json) {
    final address = json['address'] ?? {};
    final String name =
        address['city'] ??
        address['town'] ??
        address['village'] ??
        address['state'] ??
        json['name'];
    final String state = address['state'] ?? 'India';

    return Country(
      name: name,
      officialName: json['display_name'] ?? '',
      flagUrl: 'https://flagcdn.com/w640/in.png', // Default to India flag
      region: state,
      subregion: 'India',
      population: 0, // Not available
      capital: [state],
      languages: {'en': 'English'},
      currency: 'INR',
      latlng: [double.parse(json['lat']), double.parse(json['lon'])],
    );
  }

  Future<Country> getCountryByName(String name) async {
    // Try to find in static list first
    final countries = await getAllCountries();
    try {
      return countries.firstWhere(
        (c) => c.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (_) {
      // If not found, search API
      final results = await searchPlaces(name);
      if (results.isNotEmpty) return results.first;
      return countries.first; // Fallback
    }
  }
}
