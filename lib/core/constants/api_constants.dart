class ApiConstants {
  // REST Countries API
  static const String countriesBaseUrl = 'https://restcountries.com/v3.1';
  static const String allCountriesEndpoint = '$countriesBaseUrl/all';
  static String countryByNameEndpoint(String name) => '$countriesBaseUrl/name/$name';

  // Amadeus API (Test Environment)
  static const String amadeusBaseUrl = 'https://test.api.amadeus.com/v2';
  static const String amadeusAuthUrl = 'https://test.api.amadeus.com/v1/security/oauth2/token';
  
  // Flight Search
  static const String flightOffersEndpoint = '$amadeusBaseUrl/shopping/flight-offers';
  
  // Hotel Search
  static const String hotelListEndpoint = '$amadeusBaseUrl/shopping/hotel-offers';
}
