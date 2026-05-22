import 'package:flutter/material.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

/// Interface contract for country selection
abstract class PickedCountryContract {
  String get dialCode;
  String get flag;
  String get isoCode;
  String get name;
}

/// Simple configuration for the phone parser controller
class PhoneParserConfig {
  final String defaultCountryCode;
  final String defaultFlagEmoji;
  final String defaultIsoCode;
  final String defaultCountryName;

  const PhoneParserConfig({
    this.defaultCountryCode = '20',
    this.defaultFlagEmoji = '🇪🇬',
    this.defaultIsoCode = 'EG',
    this.defaultCountryName = 'Egypt',
  });
}

/// Simple controller for phone number parsing
class PhoneParserController extends ValueNotifier<ParsedPhone> {
  final TextEditingController textController;
  final PhoneParserConfig config;
  
  String _manualCountryCode = '';
  bool _isUpdating = false;

  PhoneParserController({
    String initialText = '',
    PhoneParserConfig? config,
  })  : config = config ?? const PhoneParserConfig(),
        textController = TextEditingController(text: initialText),
        super(
          ParsedPhone(
            countryCode: config?.defaultCountryCode ?? '20',
            flagEmoji: config?.defaultFlagEmoji ?? '🇪🇬',
            isoCode: config?.defaultIsoCode ?? 'EG',
            countryName: config?.defaultCountryName ?? 'Egypt',
            nationalNumber: initialText,
            fullNumber: initialText.isNotEmpty 
                ? '+${config?.defaultCountryCode ?? '20'}$initialText' 
                : '',
          ),
        ) {
    textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_isUpdating) return;
    
    final text = textController.text;
    
    if (text.isEmpty) {
      value = ParsedPhone(
        countryCode: _manualCountryCode.isEmpty ? value.countryCode : _manualCountryCode,
        flagEmoji: value.flagEmoji,
        isoCode: value.isoCode,
        countryName: value.countryName,
        nationalNumber: '',
        fullNumber: '',
      );
    } else {
      _parsePhone(text);
    }
  }

  void _parsePhone(String text) {
    try {
      final parsed = PhoneParserEngine.parse(
        input: text,
        fallbackCode: _manualCountryCode.isEmpty ? value.countryCode : _manualCountryCode,
      );
      
      // Only auto-change country if user didn't manually set one
      if (_manualCountryCode.isEmpty) {
        value = parsed;
      } else {
        // Keep manual country code
        value = ParsedPhone(
          countryCode: _manualCountryCode,
          flagEmoji: value.flagEmoji,
          isoCode: value.isoCode,
          countryName: value.countryName,
          nationalNumber: parsed.nationalNumber,
          fullNumber: '+$_manualCountryCode${parsed.nationalNumber}',
        );
      }
    } catch (e) {
      debugPrint("Parse error: $e");
    }
  }

  /// Change country code manually - THIS IS WHAT YOU NEED
  void setCountry(PickedCountryContract country) {
    _isUpdating = true;
    
    // Save the manual country code
    _manualCountryCode = country.dialCode.replaceAll('+', '');
    
    // Get current number without any country code
    String currentNumber = textController.text;
    
    // Remove any existing country code from the input
    final oldCode = value.countryCode;
    if (oldCode.isNotEmpty && currentNumber.startsWith(oldCode)) {
      currentNumber = currentNumber.substring(oldCode.length);
    } else if (oldCode.isNotEmpty && currentNumber.startsWith('+$oldCode')) {
      currentNumber = currentNumber.substring(('+$oldCode').length);
    }
    
    // Remove leading zeros
    while (currentNumber.startsWith('0')) {
      currentNumber = currentNumber.substring(1);
    }
    
    // Update text controller
    textController.text = currentNumber;
    
    // Update the value
    value = ParsedPhone(
      countryCode: _manualCountryCode,
      flagEmoji: country.flag,
      isoCode: country.isoCode,
      countryName: country.name,
      nationalNumber: currentNumber,
      fullNumber: currentNumber.isEmpty ? '' : '+$_manualCountryCode$currentNumber',
    );
    
    _isUpdating = false;
  }
  /// Clear all input
void clear() {
  _isUpdating = true;
  textController.clear();
  _isUpdating = false;
  
  value = ParsedPhone(
    countryCode: _manualCountryCode.isEmpty ? config.defaultCountryCode : _manualCountryCode,
    flagEmoji: value.flagEmoji,
    isoCode: value.isoCode,
    countryName: value.countryName,
    nationalNumber: '',
    fullNumber: '',
  );
}
  /// Reset to auto-detect mode
  void resetToAutoDetect() {
    _manualCountryCode = '';
    _parsePhone(textController.text);
  }
  

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    super.dispose();
  }
}