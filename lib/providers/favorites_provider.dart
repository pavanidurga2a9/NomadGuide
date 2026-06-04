import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/country_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<Country> _favorites = [];
  
  List<Country> get favorites => _favorites;

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');
    
    if (favoritesJson != null) {
      final List<dynamic> decodedList = json.decode(favoritesJson);
      _favorites = decodedList.map((item) => Country.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Country country) async {
    final isFav = _favorites.any((c) => c.name == country.name);
    
    if (isFav) {
      _favorites.removeWhere((c) => c.name == country.name);
    } else {
      _favorites.add(country);
    }
    notifyListeners();
    _saveFavorites();
  }

  bool isFavorite(String countryName) {
    return _favorites.any((c) => c.name == countryName);
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    // We need to implement toJson in Country model to save it appropriately, 
    // or just save names if we are lazy, but saving full object is better for offline viewing.
    // For now, let's update Country model to support toJson or just save list of names 
    // and re-fetch (but re-fetch is bad for offline). 
    // Let's implement toJson in Country model in the next step. 
    // For this initial pass, I will assume toJson exists or I will just modify this file after modifying the model.
    // Actually, I'll update the Country model first/concurrently.
    
    // Changing approach: I will save the full country object as json.
    final List<Map<String, dynamic>> jsonList = _favorites.map((c) => c.toJson()).toList();
    await prefs.setString('favorites', json.encode(jsonList));
  }
}
