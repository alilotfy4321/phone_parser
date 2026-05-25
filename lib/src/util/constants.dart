
/// Package-wide constants
class PhoneParserConstants {
  PhoneParserConstants._();
  
  /// Maximum length for national number
  static const int maxNationalNumberLength = 15;
  
  /// Minimum length for national number
  static const int minNationalNumberLength = 4;
  
  /// Default debounce delay for search
  static const Duration searchDebounceDelay = Duration(milliseconds: 300);
  
  /// Default country code (Egypt)
  static const String defaultCountryCode = '20';
  
  /// Default ISO code (Egypt)
  static const String defaultIsoCode = 'EG';
  
  /// Default flag emoji (Egypt)
  static const String defaultFlagEmoji = '🇪🇬';
  
  /// Default country name (Egypt)
  static const String defaultCountryName = 'Egypt';
}