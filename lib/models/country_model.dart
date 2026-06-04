class Country {
  final String name;
  final String officialName;
  final String flagUrl;
  final String region;
  final String subregion;
  final int population;
  final List<String> capital;
  final Map<String, String> languages;
  final String currency;
  final List<double> latlng;

  Country({
    required this.name,
    required this.officialName,
    required this.flagUrl,
    required this.region,
    required this.subregion,
    required this.population,
    required this.capital,
    required this.languages,
    required this.currency,
    required this.latlng,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'] ?? {};
    final currencyData = json['currencies'] as Map<String, dynamic>? ?? {};
    String currencyName = 'Unknown';
    if (currencyData.isNotEmpty) {
      currencyName = currencyData.values.first['name'] ?? 'Unknown';
    }

    final languagesData = json['languages'] as Map<String, dynamic>? ?? {};
    final Map<String, String> languagesMap = {};
    languagesData.forEach((key, value) {
      languagesMap[key] = value.toString();
    });
    
    final latlngData = json['latlng'] as List<dynamic>? ?? [0.0, 0.0];

    return Country(
      name: nameData['common'] ?? 'Unknown',
      officialName: nameData['official'] ?? 'Unknown',
      flagUrl: json['flags']?['png'] ?? '',
      region: json['region'] ?? 'Unknown',
      subregion: json['subregion'] ?? 'Unknown',
      population: json['population'] ?? 0,
      capital: (json['capital'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      languages: languagesMap,
      currency: currencyName,
      latlng: latlngData.map((e) => (e as num).toDouble()).toList(), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {'common': name, 'official': officialName},
      'flags': {'png': flagUrl},
      'region': region,
      'subregion': subregion,
      'population': population,
      'capital': capital,
      'languages': languages,
      'currencies': {
        'LOC' : {'name': currency}
      },
      'latlng': latlng,
    };
  }
}
