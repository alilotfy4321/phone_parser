
import '../models/parsed_phone.dart';
import '../parser/phone_parser.dart';
import '../parser/phone_validator.dart';

/// Extension for parsing phone numbers from strings
extension PhoneParsingExtension on String {
  /// Parse this string into a ParsedPhone object
  ParsedPhone parsePhone() {
    return PhoneParser.parse(input: this);
  }
  
  /// Check if this string is a valid phone number
  bool get isValidPhone => PhoneValidator.isValidNumber(this);
}

/// Extension for ParsedPhone formatting
extension PhoneFormatExtension on ParsedPhone {
  /// Get formatted with spaces
  String get formatted => _formatWithSpaces();
  
  String _formatWithSpaces() {
    final number = nationalNumber;
    if (number.isEmpty) return '';
    
    final buffer = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      if (i > 0 && (i % 3 == 0)) buffer.write(' ');
      buffer.write(number[i]);
    }
    return '+${country.phoneCode} $buffer';
  }
  
  /// Get E.164 format
  String get e164 => fullNumber;
  
  /// Get local format
  String get local => nationalNumber;
}