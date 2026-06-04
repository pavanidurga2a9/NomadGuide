import 'package:flutter/material.dart';
import '../models/country_model.dart';
import '../services/country_service.dart';

class CountryProvider with ChangeNotifier {
  final CountryService _service = CountryService();

  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = false;
  String? _error;

  // If we have filtered results (from search), show them.
  // Otherwise show the default loaded list.
  List<Country> get countries =>
      _filteredCountries.isNotEmpty ? _filteredCountries : _countries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCountries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _filteredCountries = []; // Clear search results
      _countries = await _service.getAllCountries();
      _countries.sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCountries(String query) async {
    if (query.isEmpty) {
      // Reset to default list if query is empty
      await fetchCountries();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final results = await _service.searchPlaces(query);
      _filteredCountries = results;
      // If we are searching, we show the results.
      // Note: The UI currently uses `countries` getter which returns _filtered if not empty.
      // But _countries holds the "default" list.
      // To strictly show results, we might need to adjust logic or just replace _countries temporarily?
      // Better: Update _filteredCountries and ensure getter prioritizes it.
      // Actually, if I search "Mumbai", I want to see Mumbai.
      // If I clear, I want to see defaults.
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
