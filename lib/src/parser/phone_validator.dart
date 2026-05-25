
import 'package:flutter/material.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

/// Validation utilities for phone numbers
class PhoneValidator {
  PhoneValidator._();

  /// Basic required field validator
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  /// Valid phone number validator
  static String? valid(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    
    final isValid = PhoneValidator.isValidNumber(value);
    if (!isValid) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Check if a string is a valid phone number
  static bool isValidNumber(String input) {
    try {
      final parsed = PhoneParser.parse(input: input);
      return parsed.isValid;
    } catch (_) {
      return false;
    }
  }

  /// Create a custom validator with specific country
  static FormFieldValidator<String> withCountry(ParserCountry country) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) return null;
      
      final parsed = PhoneParser.withCountry(value, country);
      return parsed.isValid ? null : 'Invalid phone number for ${country.name}';
    };
  }

  /// Create a custom validator with min/max length
  static FormFieldValidator<String> withLength({int? min, int? max}) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) return null;
      
      final digits = PhoneParser.extractDigits(value);
      if (min != null && digits.length < min) {
        return 'Phone number must have at least $min digits';
      }
      if (max != null && digits.length > max) {
        return 'Phone number must not exceed $max digits';
      }
      return null;
    };
  }
}

/// Convenience extension for validation
extension PhoneValidationExtension on String {
  bool get isValidPhone => PhoneValidator.isValidNumber(this);
}