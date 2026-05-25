import 'package:smart_phone_parser/src/data/country_registry.dart';

import '../models/parser_country.dart';
import '../models/parsed_phone.dart';

class PhoneParser {
  PhoneParser._();
  
  static const int maxNationalNumberLength = 15;
  static const int minNationalNumberLength = 4;

  static List<ParserCountry> get _sortedByCodeLength {
    final list = List<ParserCountry>.from(allCountries);
    list.sort((a, b) => b.phoneCode.length.compareTo(a.phoneCode.length));
    return list;
  }

  static Map<String, ParserCountry>? _byPhoneCode;
  static Map<String, ParserCountry>? _byIsoCode;
  
  static Map<String, ParserCountry> get _phoneCodeMap {
    _byPhoneCode ??= {
      for (var country in allCountries) country.phoneCode: country
    };
    return _byPhoneCode!;
  }
  
  static Map<String, ParserCountry> get _isoCodeMap {
    _byIsoCode ??= {
      for (var country in allCountries) country.isoCode: country
    };
    return _byIsoCode!;
  }

  static String extractDigits(String input) {
    return input.replaceAll(RegExp(r'[^\d]'), '');
  }

  static String cleanInput(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) return '';
    
    final hasPlus = trimmed.startsWith('+');
    String digits = extractDigits(trimmed);
    
    // إزالة الأصفار الزائدة من البداية مع الحفاظ على الرقم
    while (digits.startsWith('0') && digits.length > 3) {
      digits = digits.substring(1);
    }
    
    if (digits.length > maxNationalNumberLength + 4) {
      final truncated = digits.substring(0, maxNationalNumberLength + 4);
      return hasPlus ? '+$truncated' : truncated;
    }
    
    return hasPlus ? '+$digits' : digits;
  }

  static ParsedPhone parse({
    required String input,
    ParserCountry? fallbackCountry,
    bool strict = false,
  }) {
    if (input.isEmpty) {
      return ParsedPhone.empty;
    }

    String normalized = cleanInput(input);
    if (normalized.isEmpty) {
      return ParsedPhone.empty;
    }

    bool isInternational = false;
    
    // معالجة حالة 000020
    if (normalized.startsWith('00')) {
      String temp = normalized;
      while (temp.startsWith('00') && temp.length > 2) {
        temp = '+${temp.substring(2)}';
      }
      normalized = temp;
      isInternational = true;
    } else if (normalized.startsWith('+')) {
      isInternational = true;
    }

    ParserCountry? matchedCountry;
    String workingDigits = isInternational ? normalized.substring(1) : normalized;
    
    final resolvedFallback = fallbackCountry ?? defaultCountry;

    if (isInternational) {
      for (final country in _sortedByCodeLength) {
        if (workingDigits.startsWith(country.phoneCode)) {
          matchedCountry = country;
          workingDigits = workingDigits.substring(country.phoneCode.length);
          break;
        }
      }
      
      if (matchedCountry == null && strict) {
        throw Exception('No matching country code found');
      }
    } else {
      for (final country in _sortedByCodeLength) {
        if (workingDigits.startsWith(country.phoneCode) && 
            workingDigits.length > country.phoneCode.length + minNationalNumberLength - 1) {
          matchedCountry = country;
          workingDigits = workingDigits.substring(country.phoneCode.length);
          isInternational = true;
          break;
        }
      }
      
      if (matchedCountry == null && workingDigits.startsWith(resolvedFallback.phoneCode)) {
        matchedCountry = resolvedFallback;
        workingDigits = workingDigits.substring(matchedCountry.phoneCode.length);
      }
    }

    matchedCountry ??= resolvedFallback;

    // إزالة الأصفار الزائدة من البداية مع الحفاظ على أول رقم غير صفر
    while (workingDigits.startsWith('0') && workingDigits.length > 1) {
      workingDigits = workingDigits.substring(1);
    }
    
    final isValidLength = workingDigits.length >= minNationalNumberLength &&
        workingDigits.length <= maxNationalNumberLength;
    
    if (strict && !isValidLength) {
      throw Exception('National number length ${workingDigits.length} is invalid');
    }

    return ParsedPhone(
      country: matchedCountry,
      nationalNumber: workingDigits,
      fullNumber: workingDigits.isEmpty 
          ? '' 
          : '+${matchedCountry.phoneCode}$workingDigits',
      isValid: isValidLength && workingDigits.isNotEmpty,
    );
  }

  static ParsedPhone fromFullNumber(String fullNumber) {
    return parse(input: fullNumber);
  }

  static ParsedPhone withCountry(String number, ParserCountry country) {
    final digits = extractDigits(number);
    final cleanedDigits = digits.replaceFirst(RegExp('^${country.phoneCode}'), '');
    
    return ParsedPhone(
      country: country,
      nationalNumber: cleanedDigits,
      fullNumber: '+${country.phoneCode}$cleanedDigits',
      isValid: cleanedDigits.isNotEmpty && cleanedDigits.length >= minNationalNumberLength,
    );
  }

  static ParserCountry? getCountryByCode(String code) {
    return _phoneCodeMap[code];
  }
  
  static ParserCountry? getCountryByIso(String isoCode) {
    return _isoCodeMap[isoCode.toUpperCase()];
  }
  
  static List<ParserCountry> searchCountries(String query, {int? maxResults}) {
    if (query.trim().isEmpty) return List.from(allCountries);
    
    final cleanQuery = query.toLowerCase().trim();
    final results = <ParserCountry>[];
    
    for (final country in allCountries) {
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
  
  static List<ParserCountry> getAllCountries() {
    return List.from(allCountries);
  }
  
  static List<ParserCountry> getFavoriteCountries(List<String> favoriteIsoCodes) {
    final favorites = <ParserCountry>[];
    for (final iso in favoriteIsoCodes) {
      final country = getCountryByIso(iso);
      if (country != null) {
        favorites.add(country);
      }
    }
    return favorites;
  }
}