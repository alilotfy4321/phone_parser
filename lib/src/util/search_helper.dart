
import '../models/parser_country.dart';

/// Helper for searching countries
class SearchHelper {
  SearchHelper._();

  /// Search countries by name, ISO code, or phone code
  static List<ParserCountry> search(
    List<ParserCountry> countries,
    String query, {
    int? maxResults,
  }) {
    if (query.trim().isEmpty) return countries;
    
    final cleanQuery = query.toLowerCase().trim().replaceAll('+', '');
    final results = <ParserCountry>[];
    
    for (final country in countries) {
      if (maxResults != null && results.length == maxResults) break;
      
      final matchName = country.name.toLowerCase().contains(cleanQuery);
      final matchIso = country.isoCode.toLowerCase().contains(cleanQuery);
      final matchCode = country.phoneCode.contains(cleanQuery);
      
      if (matchName || matchIso || matchCode) {
        results.add(country);
      }
    }
    
    return results;
  }

  /// Filter favorite countries by ISO codes
  static List<ParserCountry> getFavorites(
    List<ParserCountry> allCountries,
    List<String> favoriteIsoCodes,
  ) {
    if (favoriteIsoCodes.isEmpty) return [];
    
    final favorites = <ParserCountry>[];
    for (final iso in favoriteIsoCodes) {
      final country = allCountries.firstWhere(
        (c) => c.isoCode == iso,
        orElse: () => throw Exception('Country not found: $iso'),
      );
      favorites.add(country);
    }
    return favorites;
  }
}