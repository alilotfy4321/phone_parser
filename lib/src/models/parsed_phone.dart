import 'package:smart_phone_parser/smart_phone_parser.dart';
import 'package:smart_phone_parser/src/data/country_registry.dart';

/// Immutable model representing a parsed phone number
class ParsedPhone {
  final ParserCountry country;
  final String nationalNumber;
  final String fullNumber;
  final bool isValid;

  const ParsedPhone({
    required this.country,
    required this.nationalNumber,
    required this.fullNumber,
    required this.isValid,
  });

  /// Creates an empty ParsedPhone instance
  static const ParsedPhone empty = ParsedPhone(
    country: defaultCountry,
    nationalNumber: '',
    fullNumber: '',
    isValid: false,
  );

  /// Convenience getters
  String get countryCode => country.phoneCode;
  String get flagEmoji => country.flagEmoji;
  String get isoCode => country.isoCode;
  String get countryName => country.name;
  String get dialCode => country.dialCode;

  /// Returns the phone number without country code
  String get localFormat => nationalNumber;

  /// Returns the international format
  String get internationalFormat => fullNumber.isNotEmpty 
      ? fullNumber 
      : '+${country.phoneCode}$nationalNumber';

  /// Creates a copy with updated fields
  ParsedPhone copyWith({
    ParserCountry? country,
    String? nationalNumber,
    String? fullNumber,
    bool? isValid,
  }) {
    return ParsedPhone(
      country: country ?? this.country,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      fullNumber: fullNumber ?? this.fullNumber,
      isValid: isValid ?? this.isValid,
    );
  }

  /// Converts to JSON map
  Map<String, dynamic> toJson() => {
    'countryCode': country.phoneCode,
    'isoCode': country.isoCode,
    'countryName': country.name,
    'flagEmoji': country.flagEmoji,
    'nationalNumber': nationalNumber,
    'fullNumber': fullNumber,
    'isValid': isValid,
  };

  /// Creates from JSON map
  factory ParsedPhone.fromJson(Map<String, dynamic> json) {
    // Get country from stored data or use default
    final countryCode = json['countryCode'] as String? ?? '';
    final country = countryCode.isNotEmpty 
        ? (PhoneParser.getCountryByCode(countryCode) ?? defaultCountry)
        : defaultCountry;
    
    return ParsedPhone(
      country: country,
      nationalNumber: json['nationalNumber'] as String? ?? '',
      fullNumber: json['fullNumber'] as String? ?? '',
      isValid: json['isValid'] as bool? ?? false,
    );
  }

  @override
  String toString() => fullNumber;
}