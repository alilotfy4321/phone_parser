import '../data/country_registry.dart';
import '../models/phone_model.dart';

/// Exception thrown when phone number parsing fails
class PhoneParseException implements Exception {
  final String message;
  final String? input;
  
  PhoneParseException(this.message, {this.input});
  
  @override
  String toString() => 'PhoneParseException: $message${input != null ? ' (Input: $input)' : ''}';
}

/// Core parsing engine for international phone numbers
class PhoneParserEngine {
  PhoneParserEngine._(); // Private constructor
  
  /// Maximum length for a national number (excluding country code)
  static const int maxNationalNumberLength = 15;
  
  /// Minimum length for a national number
  static const int minNationalNumberLength = 4;

  /// Cleans formatting characters but preserves the leading plus marker if it exists
  static String cleanInputFormatting(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return '';
    
    final hasPlus = trimmed.startsWith('+');
    final digits = extractDigits(trimmed);
    
    // Prevent extremely long inputs
    if (digits.length > maxNationalNumberLength + 4) {
      return hasPlus ? '+${digits.substring(0, maxNationalNumberLength + 4)}' : digits.substring(0, maxNationalNumberLength + 4);
    }
    
    return hasPlus ? '+$digits' : digits;
  }

  /// Extracts numbers only and removes absolutely all non-numeric clutter (including '+')
  static String extractDigits(String input) {
    return input.replaceAll(RegExp(r'[^\d]'), '');
  }

  /// Validates if a phone number appears to be valid
  static bool isValidPhoneNumber(String input, {String? fallbackCode}) {
    try {
      final parsed = parse(input: input, fallbackCode: fallbackCode);
      return parsed.isValid && parsed.nationalNumber.length >= minNationalNumberLength;
    } catch (_) {
      return false;
    }
  }

  static ParsedPhone parse({
    required String input,
    String? fallbackCode,
    bool strict = false,
  }) {
    if (input.isEmpty) {
      return ParsedPhone.empty;
    }

    // 1. Sanitize input but keep track of international context
    String normalized = cleanInputFormatting(input);
    if (normalized.isEmpty) {
      return ParsedPhone.empty;
    }

    bool isInternational = false;

    // 2. Normalize "00" prefix to standard international "+" format
    if (normalized.startsWith('00')) {
      normalized = '+${normalized.substring(2)}';
      isInternational = true;
    } else if (normalized.startsWith('+')) {
      isInternational = true;
    }

    ParserCountry? targetCountry;
    String workingDigits = isInternational ? normalized.substring(1) : normalized;
    final String resolvedFallbackCode = fallbackCode ?? '20';

    // 3. Match country code criteria safely
    if (isInternational) {
      // Look through sorted list so longer codes match first (e.g., +1242 before +1)
      for (final country in CountryRegistry.sortedByCodeLength) {
        if (workingDigits.startsWith(country.phoneCode)) {
          targetCountry = country;
          workingDigits = workingDigits.substring(country.phoneCode.length);
          break;
        }
      }
      
      // If no country matched and we're in strict mode, throw
      if (targetCountry == null && strict) {
        throw PhoneParseException('No matching country code found for international number', input: input);
      }
    } else {
      // Check if the number might be international without the plus
      for (final country in CountryRegistry.sortedByCodeLength) {
        if (workingDigits.startsWith(country.phoneCode) && 
            workingDigits.length > country.phoneCode.length + minNationalNumberLength - 1) {
          targetCountry = country;
          workingDigits = workingDigits.substring(country.phoneCode.length);
          isInternational = true;
          break;
        }
      }
      
      // If still no match, try to use fallback or detect by code
      if (targetCountry == null && workingDigits.startsWith(resolvedFallbackCode)) {
        targetCountry = CountryRegistry.fromPhoneCode(resolvedFallbackCode);
        if (targetCountry != null) {
          workingDigits = workingDigits.substring(targetCountry.phoneCode.length);
        }
      }
    }

    // 4. Resolve fallback data state if no explicit match was detected
    targetCountry ??= CountryRegistry.fromPhoneCode(resolvedFallbackCode);
    
    if (targetCountry == null && !strict) {
      targetCountry = CountryRegistry.countries.first;
    }
    
    if (targetCountry == null) {
      throw PhoneParseException('Unable to determine country for phone number', input: input);
    }

    // 5. Clean national number (Strip local trunk prefixes / leading zeroes)
    while (workingDigits.startsWith('0')) {
      workingDigits = workingDigits.substring(1);
    }
    
    // Validate national number length
    if (strict && (workingDigits.length < minNationalNumberLength || 
        workingDigits.length > maxNationalNumberLength)) {
      throw PhoneParseException(
        'National number length ${workingDigits.length} is invalid. '
        'Expected between $minNationalNumberLength and $maxNationalNumberLength digits',
        input: input
      );
    }

    return ParsedPhone(
      countryCode: targetCountry.phoneCode,
      isoCode: targetCountry.isoCode,
      countryName: targetCountry.name,
      flagEmoji: targetCountry.flagEmoji,
      nationalNumber: workingDigits,
      fullNumber: workingDigits.isEmpty 
          ? '' 
          : '+${targetCountry.phoneCode}$workingDigits',
    );
  }
}