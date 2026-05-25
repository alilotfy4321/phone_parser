import '../models/parsed_phone.dart';

/// Formats phone numbers for display
class PhoneFormatter {
  PhoneFormatter._();

  /// Format a phone number in E.164 format
  static String toE164(ParsedPhone phone) {
    return phone.fullNumber;
  }

  /// Format with spaces for readability
  static String toReadable(ParsedPhone phone, {String separator = ' '}) {
    final number = phone.nationalNumber;
    if (number.isEmpty) return '';
    
    // Simple grouping - groups of 3-4 digits
    final buffer = StringBuffer();
    int i = 0;
    while (i < number.length) {
      if (i > 0) buffer.write(separator);
      final remaining = number.length - i;
      if (remaining > 4) {
        buffer.write(number.substring(i, i + 3));
        i += 3;
      } else if (remaining > 3) {
        buffer.write(number.substring(i, i + 2));
        i += 2;
      } else {
        buffer.write(number.substring(i));
        break;
      }
    }
    
    return '+${phone.country.phoneCode} $buffer';
  }

  /// Format with international prefix
  static String toInternational(ParsedPhone phone) {
    return phone.fullNumber;
  }

  /// Format for local display (without country code)
  static String toLocal(ParsedPhone phone) {
    return phone.nationalNumber;
  }

  /// Format with custom mask pattern
  /// 
  /// Example masks:
  /// - `'### ### ####'` -> +20 101 234 5678
  /// - `'(###) ###-####'` -> +1 (212) 555-1234
  /// - `'##-###-####'` -> +20 10-123-45678
  /// - `'###-###-####'` -> +966 501-234-567
  /// 
  /// The `#` symbol represents a digit from the phone number
  static String withMask(ParsedPhone phone, {String mask = '### ### ####'}) {
    final number = phone.nationalNumber;
    if (number.isEmpty) return '';
    
    final result = StringBuffer();
    int numberIndex = 0;
    
    for (int i = 0; i < mask.length && numberIndex < number.length; i++) {
      if (mask[i] == '#') {
        result.write(number[numberIndex]);
        numberIndex++;
      } else {
        result.write(mask[i]);
      }
    }
    
    // Add any remaining digits if mask is shorter than number
    if (numberIndex < number.length) {
      result.write(number.substring(numberIndex));
    }
    
    return '+${phone.country.phoneCode} $result';
  }

  /// Format with country-specific formatting
  static String withCountryFormat(ParsedPhone phone) {
    final countryCode = phone.country.phoneCode;
    final number = phone.nationalNumber;
    
    switch (countryCode) {
      case '1': // US, Canada
        if (number.length == 10) {
          return '+1 (${number.substring(0, 3)}) ${number.substring(3, 6)}-${number.substring(6)}';
        }
        break;
      case '20': // Egypt
        if (number.length == 10) {
          return '+20 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
        }
        break;
      case '44': // UK
        if (number.length == 10) {
          return '+44 ${number.substring(0, 4)} ${number.substring(4, 7)} ${number.substring(7)}';
        }
        break;
      case '966': // Saudi Arabia
        if (number.length == 9) {
          return '+966 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
        }
        break;
      case '971': // UAE
        if (number.length == 9) {
          return '+971 ${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6)}';
        }
        break;
      case '91': // India
        if (number.length == 10) {
          return '+91 ${number.substring(0, 5)} ${number.substring(5)}';
        }
        break;
    }
    
    // Fallback to readable format
    return toReadable(phone);
  }

  /// Format with compact style (no spaces, just country code + number)
  static String toCompact(ParsedPhone phone) {
    return phone.fullNumber;
  }

  /// Format for display in contact list
  static String forContactList(ParsedPhone phone) {
    return '${phone.flagEmoji} ${phone.dialCode} ${toLocal(phone)}';
  }

  /// Get formatted number with all possible formats
  static Map<String, String> getAllFormats(ParsedPhone phone) {
    return {
      'e164': toE164(phone),
      'international': toInternational(phone),
      'local': toLocal(phone),
      'readable': toReadable(phone),
      'compact': toCompact(phone),
      'contact': forContactList(phone),
      'withMask': withMask(phone),
      'countryFormat': withCountryFormat(phone),
    };
  }
}