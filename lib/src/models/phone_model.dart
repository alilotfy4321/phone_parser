
/// Immutable model representing a parsed phone number
class ParsedPhone  {
  final String countryCode;    // e.g., "20"
  final String isoCode;        // e.g., "EG"
  final String countryName;    // e.g., "Egypt"
  final String flagEmoji;      // e.g., "🇪🇬"
  final String nationalNumber;  // e.g., "123456789" (Cleaned of leading zeroes)
  final String fullNumber;       // e.g., "+20123456789"

  const ParsedPhone({
    required this.countryCode,
    required this.isoCode,
    required this.countryName,
    required this.flagEmoji,
    required this.nationalNumber,
    required this.fullNumber,
  });

  /// Creates an empty ParsedPhone instance
  static const ParsedPhone empty = ParsedPhone(
    countryCode: '',
    isoCode: '',
    countryName: '',
    flagEmoji: '',
    nationalNumber: '',
    fullNumber: '',
  );

  /// Checks if this is a valid parsed phone number
  bool get isValid => countryCode.isNotEmpty && nationalNumber.isNotEmpty;

  /// Returns the phone number without country code
  String get localFormat => nationalNumber;

  /// Returns the international format
  String get internationalFormat => fullNumber.isNotEmpty ? fullNumber : '+$countryCode$nationalNumber';

  /// Creates a copy with updated fields
  ParsedPhone copyWith({
    String? countryCode,
    String? isoCode,
    String? countryName,
    String? flagEmoji,
    String? nationalNumber,
    String? fullNumber,
  }) {
    return ParsedPhone(
      countryCode: countryCode ?? this.countryCode,
      isoCode: isoCode ?? this.isoCode,
      countryName: countryName ?? this.countryName,
      flagEmoji: flagEmoji ?? this.flagEmoji,
      nationalNumber: nationalNumber ?? this.nationalNumber,
      fullNumber: fullNumber ?? this.fullNumber,
    );
  }

  /// Converts to JSON map
  Map<String, dynamic> toJson() => {
    'countryCode': countryCode,
    'isoCode': isoCode,
    'countryName': countryName,
    'flagEmoji': flagEmoji,
    'nationalNumber': nationalNumber,
    'fullNumber': fullNumber,
  };

  /// Creates from JSON map
  factory ParsedPhone.fromJson(Map<String, dynamic> json) {
    return ParsedPhone(
      countryCode: json['countryCode'] as String? ?? '',
      isoCode: json['isoCode'] as String? ?? '',
      countryName: json['countryName'] as String? ?? '',
      flagEmoji: json['flagEmoji'] as String? ?? '',
      nationalNumber: json['nationalNumber'] as String? ?? '',
      fullNumber: json['fullNumber'] as String? ?? '',
    );
  }

  @override
  String toString() => fullNumber;

  
}