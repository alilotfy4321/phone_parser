import 'dart:collection';
import '../engine/phone_parser_controller.dart';

/// Represents a country with its phone dialing information
class ParserCountry implements PickedCountryContract {
  @override
  final String name;
  @override
  final String isoCode;
  final String phoneCode;
  final String flagEmoji;

  const ParserCountry({
    required this.name,
    required this.isoCode,
    required this.phoneCode,
    required this.flagEmoji,
  });

  /// Returns the full dial string including the plus sign
  String get dialString => '+$phoneCode';
  
  // Implement PickedCountryContract interface
  @override
  String get dialCode => phoneCode;
  
  @override
  String get flag => flagEmoji;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParserCountry &&
          runtimeType == other.runtimeType &&
          isoCode == other.isoCode;

  @override
  int get hashCode => isoCode.hashCode;

  @override
  String toString() => '$name ($isoCode) +$phoneCode';
}

/// Thread-safe registry for managing country data with optimized lookups
class CountryRegistry {
  // Private constructor for singleton pattern
  CountryRegistry._internal();
  static final CountryRegistry _instance = CountryRegistry._internal();
  static CountryRegistry get instance => _instance;

  /// Comprehensive list of global countries and territories
  static const List<ParserCountry> countries = [
    ParserCountry(name: 'Afghanistan', isoCode: 'AF', phoneCode: '93', flagEmoji: '🇦🇫'),
    ParserCountry(name: 'Albania', isoCode: 'AL', phoneCode: '355', flagEmoji: '🇦🇱'),
    ParserCountry(name: 'Algeria', isoCode: 'DZ', phoneCode: '213', flagEmoji: '🇩🇿'),
    ParserCountry(name: 'Andorra', isoCode: 'AD', phoneCode: '376', flagEmoji: '🇦🇩'),
    ParserCountry(name: 'Angola', isoCode: 'AO', phoneCode: '244', flagEmoji: '🇦🇴'),
    ParserCountry(name: 'Argentina', isoCode: 'AR', phoneCode: '54', flagEmoji: '🇦🇷'),
    ParserCountry(name: 'Armenia', isoCode: 'AM', phoneCode: '374', flagEmoji: '🇦🇲'),
    ParserCountry(name: 'Australia', isoCode: 'AU', phoneCode: '61', flagEmoji: '🇦🇺'),
    ParserCountry(name: 'Austria', isoCode: 'AT', phoneCode: '43', flagEmoji: '🇦🇹'),
    ParserCountry(name: 'Azerbaijan', isoCode: 'AZ', phoneCode: '994', flagEmoji: '🇦🇿'),
    ParserCountry(name: 'Bahrain', isoCode: 'BH', phoneCode: '973', flagEmoji: '🇧🇭'),
    ParserCountry(name: 'Bangladesh', isoCode: 'BD', phoneCode: '880', flagEmoji: '🇧🇩'),
    ParserCountry(name: 'Belgium', isoCode: 'BE', phoneCode: '32', flagEmoji: '🇧🇪'),
    ParserCountry(name: 'Bolivia', isoCode: 'BO', phoneCode: '591', flagEmoji: '🇧🇴'),
    ParserCountry(name: 'Bosnia and Herzegovina', isoCode: 'BA', phoneCode: '387', flagEmoji: '🇧🇦'),
    ParserCountry(name: 'Brazil', isoCode: 'BR', phoneCode: '55', flagEmoji: '🇧🇷'),
    ParserCountry(name: 'Bulgaria', isoCode: 'BG', phoneCode: '359', flagEmoji: '🇧🇬'),
    ParserCountry(name: 'Cambodia', isoCode: 'KH', phoneCode: '855', flagEmoji: '🇰🇭'),
    ParserCountry(name: 'Cameroon', isoCode: 'CM', phoneCode: '237', flagEmoji: '🇨🇲'),
    ParserCountry(name: 'Canada', isoCode: 'CA', phoneCode: '1', flagEmoji: '🇨🇦'),
    ParserCountry(name: 'Chile', isoCode: 'CL', phoneCode: '56', flagEmoji: '🇨🇱'),
    ParserCountry(name: 'China', isoCode: 'CN', phoneCode: '86', flagEmoji: '🇨🇳'),
    ParserCountry(name: 'Colombia', isoCode: 'CO', phoneCode: '57', flagEmoji: '🇨🇴'),
    ParserCountry(name: 'Costa Rica', isoCode: 'CR', phoneCode: '506', flagEmoji: '🇨🇷'),
    ParserCountry(name: 'Croatia', isoCode: 'HR', phoneCode: '385', flagEmoji: '🇭🇷'),
    ParserCountry(name: 'Cuba', isoCode: 'CU', phoneCode: '53', flagEmoji: '🇨🇺'),
    ParserCountry(name: 'Cyprus', isoCode: 'CY', phoneCode: '357', flagEmoji: '🇨🇾'),
    ParserCountry(name: 'Czech Republic', isoCode: 'CZ', phoneCode: '420', flagEmoji: '🇨🇿'),
    ParserCountry(name: 'Denmark', isoCode: 'DK', phoneCode: '45', flagEmoji: '🇩🇰'),
    ParserCountry(name: 'Djibouti', isoCode: 'DJ', phoneCode: '253', flagEmoji: '🇩🇯'),
    ParserCountry(name: 'Ecuador', isoCode: 'EC', phoneCode: '593', flagEmoji: '🇪🇨'),
    ParserCountry(name: 'Egypt', isoCode: 'EG', phoneCode: '20', flagEmoji: '🇪🇬'),
    ParserCountry(name: 'Estonia', isoCode: 'EE', phoneCode: '372', flagEmoji: '🇪🇪'),
    ParserCountry(name: 'Ethiopia', isoCode: 'ET', phoneCode: '251', flagEmoji: '🇪🇹'),
    ParserCountry(name: 'Finland', isoCode: 'FI', phoneCode: '358', flagEmoji: '🇫🇮'),
    ParserCountry(name: 'France', isoCode: 'FR', phoneCode: '33', flagEmoji: '🇫🇷'),
    ParserCountry(name: 'Georgia', isoCode: 'GE', phoneCode: '995', flagEmoji: '🇬🇪'),
    ParserCountry(name: 'Germany', isoCode: 'DE', phoneCode: '49', flagEmoji: '🇩🇪'),
    ParserCountry(name: 'Ghana', isoCode: 'GH', phoneCode: '233', flagEmoji: '🇬🇭'),
    ParserCountry(name: 'Greece', isoCode: 'GR', phoneCode: '30', flagEmoji: '🇬🇷'),
    ParserCountry(name: 'Honduras', isoCode: 'HN', phoneCode: '504', flagEmoji: '🇭🇳'),
    ParserCountry(name: 'Hong Kong', isoCode: 'HK', phoneCode: '852', flagEmoji: '🇭🇰'),
    ParserCountry(name: 'Hungary', isoCode: 'HU', phoneCode: '36', flagEmoji: '🇭🇺'),
    ParserCountry(name: 'Iceland', isoCode: 'IS', phoneCode: '354', flagEmoji: '🇮🇸'),
    ParserCountry(name: 'India', isoCode: 'IN', phoneCode: '91', flagEmoji: '🇮🇳'),
    ParserCountry(name: 'Indonesia', isoCode: 'ID', phoneCode: '62', flagEmoji: '🇮🇩'),
    ParserCountry(name: 'Iran', isoCode: 'IR', phoneCode: '98', flagEmoji: '🇮🇷'),
    ParserCountry(name: 'Iraq', isoCode: 'IQ', phoneCode: '964', flagEmoji: '🇮🇶'),
    ParserCountry(name: 'Ireland', isoCode: 'IE', phoneCode: '353', flagEmoji: '🇮🇪'),
    ParserCountry(name: 'Italy', isoCode: 'IT', phoneCode: '39', flagEmoji: '🇮🇹'),
    ParserCountry(name: 'Japan', isoCode: 'JP', phoneCode: '81', flagEmoji: '🇯🇵'),
    ParserCountry(name: 'Jordan', isoCode: 'JO', phoneCode: '962', flagEmoji: '🇯🇴'),
    ParserCountry(name: 'Kazakhstan', isoCode: 'KZ', phoneCode: '7', flagEmoji: '🇰🇿'),
    ParserCountry(name: 'Kenya', isoCode: 'KE', phoneCode: '254', flagEmoji: '🇰🇪'),
    ParserCountry(name: 'Kuwait', isoCode: 'KW', phoneCode: '965', flagEmoji: '🇰🇼'),
    ParserCountry(name: 'Lebanon', isoCode: 'LB', phoneCode: '961', flagEmoji: '🇱🇧'),
    ParserCountry(name: 'Libya', isoCode: 'LY', phoneCode: '218', flagEmoji: '🇱🇾'),
    ParserCountry(name: 'Malaysia', isoCode: 'MY', phoneCode: '60', flagEmoji: '🇲🇾'),
    ParserCountry(name: 'Maldives', isoCode: 'MV', phoneCode: '960', flagEmoji: '🇲🇻'),
    ParserCountry(name: 'Mexico', isoCode: 'MX', phoneCode: '52', flagEmoji: '🇲🇽'),
    ParserCountry(name: 'Morocco', isoCode: 'MA', phoneCode: '212', flagEmoji: '🇲🇦'),
    ParserCountry(name: 'Netherlands', isoCode: 'NL', phoneCode: '31', flagEmoji: '🇳🇱'),
    ParserCountry(name: 'New Zealand', isoCode: 'NZ', phoneCode: '64', flagEmoji: '🇳🇿'),
    ParserCountry(name: 'Nigeria', isoCode: 'NG', phoneCode: '234', flagEmoji: '🇳🇬'),
    ParserCountry(name: 'Norway', isoCode: 'NO', phoneCode: '47', flagEmoji: '🇳🇴'),
    ParserCountry(name: 'Oman', isoCode: 'OM', phoneCode: '968', flagEmoji: '🇴🇲'),
    ParserCountry(name: 'Pakistan', isoCode: 'PK', phoneCode: '92', flagEmoji: '🇵🇰'),
    ParserCountry(name: 'Palestine', isoCode: 'PS', phoneCode: '970', flagEmoji: '🇵🇸'),
    ParserCountry(name: 'Peru', isoCode: 'PE', phoneCode: '51', flagEmoji: '🇵🇪'),
    ParserCountry(name: 'Philippines', isoCode: 'PH', phoneCode: '63', flagEmoji: '🇵🇭'),
    ParserCountry(name: 'Poland', isoCode: 'PL', phoneCode: '48', flagEmoji: '🇵🇱'),
    ParserCountry(name: 'Portugal', isoCode: 'PT', phoneCode: '351', flagEmoji: '🇵🇹'),
    ParserCountry(name: 'Qatar', isoCode: 'QA', phoneCode: '974', flagEmoji: '🇶🇦'),
    ParserCountry(name: 'Romania', isoCode: 'RO', phoneCode: '40', flagEmoji: '🇷🇴'),
    ParserCountry(name: 'Russia', isoCode: 'RU', phoneCode: '7', flagEmoji: '🇷🇺'),
    ParserCountry(name: 'Saudi Arabia', isoCode: 'SA', phoneCode: '966', flagEmoji: '🇸🇦'),
    ParserCountry(name: 'Singapore', isoCode: 'SG', phoneCode: '65', flagEmoji: '🇸🇬'),
    ParserCountry(name: 'South Africa', isoCode: 'ZA', phoneCode: '27', flagEmoji: '🇿🇦'),
    ParserCountry(name: 'South Korea', isoCode: 'KR', phoneCode: '82', flagEmoji: '🇰🇷'),
    ParserCountry(name: 'Spain', isoCode: 'ES', phoneCode: '34', flagEmoji: '🇪🇸'),
    ParserCountry(name: 'Sri Lanka', isoCode: 'LK', phoneCode: '94', flagEmoji: '🇱🇰'),
    ParserCountry(name: 'Sudan', isoCode: 'SD', phoneCode: '249', flagEmoji: '🇸🇩'),
    ParserCountry(name: 'Sweden', isoCode: 'SE', phoneCode: '46', flagEmoji: '🇸🇪'),
    ParserCountry(name: 'Switzerland', isoCode: 'CH', phoneCode: '41', flagEmoji: '🇨🇭'),
    ParserCountry(name: 'Syria', isoCode: 'SY', phoneCode: '963', flagEmoji: '🇸🇾'),
    ParserCountry(name: 'Tunisia', isoCode: 'TN', phoneCode: '216', flagEmoji: '🇹🇳'),
    ParserCountry(name: 'Turkey', isoCode: 'TR', phoneCode: '90', flagEmoji: '🇹🇷'),
    ParserCountry(name: 'Ukraine', isoCode: 'UA', phoneCode: '380', flagEmoji: '🇺🇦'),
    ParserCountry(name: 'United Arab Emirates', isoCode: 'AE', phoneCode: '971', flagEmoji: '🇦🇪'),
    ParserCountry(name: 'United Kingdom', isoCode: 'GB', phoneCode: '44', flagEmoji: '🇬🇧'),
    ParserCountry(name: 'United States', isoCode: 'US', phoneCode: '1', flagEmoji: '🇺🇸'),
    ParserCountry(name: 'Yemen', isoCode: 'YE', phoneCode: '967', flagEmoji: '🇾🇪'),
  ];

  // Static getters for cached data (initialized lazily)
  static Map<String, ParserCountry>? _byIsoCode;
  static Map<String, ParserCountry>? _byPhoneCode;
  static List<ParserCountry>? _sortedByCodeLength;
  static List<ParserCountry>? _sortedByName;

  /// Returns countries sorted by phone code length (longest first) for prefix matching
  static List<ParserCountry> get sortedByCodeLength {
    _sortedByCodeLength ??= List.from(countries)
      ..sort((a, b) => b.phoneCode.length.compareTo(a.phoneCode.length));
    return _sortedByCodeLength!;
  }

  /// Returns countries sorted alphabetically by name
  static List<ParserCountry> get sortedByName {
    _sortedByName ??= List.from(countries)
      ..sort((a, b) => a.name.compareTo(b.name));
    return _sortedByName!;
  }

  /// O(1) lookup by ISO code
  static ParserCountry? fromIsoCode(String isoCode) {
    _byIsoCode ??= Map.unmodifiable(
      {for (var country in countries) country.isoCode: country}
    );
    return _byIsoCode![isoCode.toUpperCase()];
  }

  /// O(1) lookup by phone code
  static ParserCountry? fromPhoneCode(String phoneCode) {
    _byPhoneCode ??= Map.unmodifiable(
      {for (var country in countries) country.phoneCode: country}
    );
    return _byPhoneCode![phoneCode];
  }

  /// Optimized search with early termination and result limiting
  static List<ParserCountry> search(String query, {int? maxResults}) {
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

  /// Checks if a phone code is valid
  static bool isValidPhoneCode(String code) {
    _byPhoneCode ??= Map.unmodifiable(
      {for (var country in countries) country.phoneCode: country}
    );
    return _byPhoneCode!.containsKey(code);
  }

  /// Checks if an ISO code is valid
  static bool isValidIsoCode(String code) {
    _byIsoCode ??= Map.unmodifiable(
      {for (var country in countries) country.isoCode: country}
    );
    return _byIsoCode!.containsKey(code.toUpperCase());
  }
}