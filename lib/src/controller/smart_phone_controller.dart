import 'package:flutter/material.dart';
import 'package:smart_phone_parser/src/data/country_registry.dart';
import '../models/parser_country.dart';
import '../models/parsed_phone.dart';
import '../parser/phone_parser.dart';
import 'phone_rules.dart';

class SmartPhoneController extends ValueNotifier<ParsedPhone> {
  final TextEditingController textController;
  
  ParserCountry? _manualCountry;
  bool _isUpdating = false;

  SmartPhoneController({
    String? initialNumber,
    ParserCountry? initialCountry,
  })  : textController = TextEditingController(),
        super(ParsedPhone.empty) {
    textController.addListener(_onTextChanged);
    
    if (initialNumber != null && initialNumber.isNotEmpty) {
      setFullNumber(initialNumber);
    } else if (initialCountry != null) {
      _manualCountry = initialCountry;
      value = ParsedPhone(
        country: initialCountry,
        nationalNumber: '',
        fullNumber: '',
        isValid: false,
      );
    } else {
      value = const ParsedPhone(
        country: defaultCountry,
        nationalNumber: '',
        fullNumber: '',
        isValid: false,
      );
    }
  }

  factory SmartPhoneController.fromFullNumber(String fullNumber) {
    final controller = SmartPhoneController();
    controller.setFullNumber(fullNumber);
    return controller;
  }

  void _onTextChanged() {
    if (_isUpdating) return;
    
    final text = textController.text;
    
    if (text.isEmpty) {
      value = ParsedPhone(
        country: _manualCountry ?? value.country,
        nationalNumber: '',
        fullNumber: '',
        isValid: false,
      );
      return;
    }
    
    _parsePhone(text);
  }

  void _parsePhone(String text) {
    if (_isUpdating) return;
    
    String workingNumber = text;
    
    if (_manualCountry != null) {
      // إزالة + وكود الدولة
      if (workingNumber.startsWith('+')) {
        workingNumber = workingNumber.substring(1);
      }
      if (workingNumber.startsWith(_manualCountry!.phoneCode)) {
        workingNumber = workingNumber.substring(_manualCountry!.phoneCode.length);
      }
      
      // إزالة الصفر حسب قواعد الدولة
      final rules = PhoneRules.getRules(_manualCountry!.phoneCode);
      if (rules != null && rules.removeLeadingZero) {
        while (workingNumber.startsWith('0')) {
          workingNumber = workingNumber.substring(1);
        }
      }
      
      // الحد الأقصى للطول حسب قواعد الدولة
      if (rules != null && workingNumber.length > rules.maxLength) {
        workingNumber = workingNumber.substring(0, rules.maxLength);
        _isUpdating = true;
        textController.text = workingNumber;
        _isUpdating = false;
        return;
      }
      
      // التحقق من صحة الرقم حسب قواعد الدولة
      bool isValid = false;
      if (rules != null) {
        isValid = PhoneRules.isValidNumber(_manualCountry!.phoneCode, workingNumber);
      } else {
        isValid = workingNumber.isNotEmpty && workingNumber.length >= 4;
      }
      
      // منع الكتابة أكثر من الحد الأقصى
      if (rules != null && workingNumber.length >= rules.maxLength) {
        _isUpdating = true;
        textController.text = workingNumber;
        _isUpdating = false;
      }
      
      value = ParsedPhone(
        country: _manualCountry!,
        nationalNumber: workingNumber,
        fullNumber: workingNumber.isEmpty ? '' : '+${_manualCountry!.phoneCode}$workingNumber',
        isValid: isValid,
      );
    } else {
      // Auto detect
      try {
        final parsed = PhoneParser.parse(input: workingNumber);
        value = parsed;
      } catch (e) {
        debugPrint('Parse error: $e');
      }
    }
  }

  ParsedPhone get phone => value;
  ParserCountry get country => value.country;
  String get fullNumber => value.fullNumber;
  String get nationalNumber => value.nationalNumber;
  String get countryCode => value.countryCode;
  String get flagEmoji => value.flagEmoji;
  String get isoCode => value.isoCode;
  String get countryName => value.countryName;
  String get dialCode => value.dialCode;
  bool get isValid => value.isValid;

  void setFullNumber(String fullNumber) {
    _isUpdating = true;
    
    String cleaned = fullNumber;
    
    // إزالة الأصفار الزائدة
    while (cleaned.startsWith('0') && cleaned.length > 3) {
      cleaned = cleaned.substring(1);
    }
    
    if (!cleaned.startsWith('+')) {
      for (final country in allCountries) {
        if (cleaned.startsWith(country.phoneCode)) {
          cleaned = '+$cleaned';
          break;
        }
      }
    }
    
    final parsed = PhoneParser.parse(input: cleaned);
    _manualCountry = parsed.country;
    
    // التحقق من قواعد الدولة
    final rules = PhoneRules.getRules(_manualCountry!.phoneCode);
    String nationalNumber = parsed.nationalNumber;
    
    if (rules != null) {
      // إزالة الصفر إذا كانت الدولة تتطلب ذلك
      if (rules.removeLeadingZero) {
        while (nationalNumber.startsWith('0')) {
          nationalNumber = nationalNumber.substring(1);
        }
      }
      
      // التأكد من الحد الأقصى للطول
      if (nationalNumber.length > rules.maxLength) {
        nationalNumber = nationalNumber.substring(0, rules.maxLength);
      }
    }
    
    textController.text = nationalNumber;
    
    final isValid = rules != null 
        ? PhoneRules.isValidNumber(_manualCountry!.phoneCode, nationalNumber)
        : parsed.isValid;
    
    value = ParsedPhone(
      country: parsed.country,
      nationalNumber: nationalNumber,
      fullNumber: '+${parsed.country.phoneCode}$nationalNumber',
      isValid: isValid,
    );
    
    _isUpdating = false;
  }

  void setCountry(ParserCountry country) {
    _isUpdating = true;
    _manualCountry = country;
    
    String currentNumber = textController.text;
    
    // إزالة كود الدولة القديم
    for (final c in allCountries) {
      if (currentNumber.startsWith(c.phoneCode)) {
        currentNumber = currentNumber.substring(c.phoneCode.length);
        break;
      }
    }
    
    // إزالة علامة +
    if (currentNumber.startsWith('+')) {
      currentNumber = currentNumber.substring(1);
    }
    
    // إزالة الأصفار حسب قواعد الدولة الجديدة
    final rules = PhoneRules.getRules(country.phoneCode);
    if (rules != null && rules.removeLeadingZero) {
      while (currentNumber.startsWith('0')) {
        currentNumber = currentNumber.substring(1);
      }
    }
    
    // التأكد من الحد الأقصى للطول
    if (rules != null && currentNumber.length > rules.maxLength) {
      currentNumber = currentNumber.substring(0, rules.maxLength);
    }
    
    textController.text = currentNumber;
    
    // التحقق من الصحة
    bool isValid = false;
    if (rules != null) {
      isValid = PhoneRules.isValidNumber(country.phoneCode, currentNumber);
    } else {
      isValid = currentNumber.isNotEmpty;
    }
    
    value = ParsedPhone(
      country: country,
      nationalNumber: currentNumber,
      fullNumber: currentNumber.isEmpty ? '' : '+${country.phoneCode}$currentNumber',
      isValid: isValid,
    );
    
    _isUpdating = false;
  }

  void clear() {
    _isUpdating = true;
    textController.clear();
    _manualCountry = null;
    value = const ParsedPhone(
      country: defaultCountry,
      nationalNumber: '',
      fullNumber: '',
      isValid: false,
    );
    _isUpdating = false;
  }

  void resetToAutoDetect() {
    _isUpdating = true;
    _manualCountry = null;
    
    final text = textController.text;
    if (text.isNotEmpty) {
      final parsed = PhoneParser.parse(input: text);
      value = parsed;
    } else {
      value = const ParsedPhone(
        country: defaultCountry,
        nationalNumber: '',
        fullNumber: '',
        isValid: false,
      );
    }
    
    _isUpdating = false;
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    super.dispose();
  }
}