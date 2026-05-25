import 'package:flutter_test/flutter_test.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

void main() {
  group('SmartPhoneController Tests', () {
    
    test('Egypt numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      // اختبار أرقام مصر
      controller.setFullNumber('+201060667064');
      expect(controller.nationalNumber, '1060667064');
      expect(controller.fullNumber, '+201060667064');
      expect(controller.isValid, true);
      
      controller.setFullNumber('01060667064');
      expect(controller.nationalNumber, '1060667064');
      expect(controller.fullNumber, '+201060667064');
      
      controller.setFullNumber('1060667064');
      expect(controller.nationalNumber, '1060667064');
      expect(controller.fullNumber, '+201060667064');
    });
    
    test('Saudi Arabia numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+966501234567');
      expect(controller.nationalNumber, '501234567');
      expect(controller.fullNumber, '+966501234567');
      expect(controller.isValid, true);
      
      controller.setFullNumber('0501234567');
      expect(controller.nationalNumber, '501234567');
      expect(controller.fullNumber, '+966501234567');
      
      controller.setFullNumber('501234567');
      expect(controller.nationalNumber, '501234567');
      expect(controller.fullNumber, '+966501234567');
    });
    
    test('UAE numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+971501234567');
      expect(controller.nationalNumber, '501234567');
      expect(controller.fullNumber, '+971501234567');
      expect(controller.isValid, true);
      
      controller.setFullNumber('0501234567');
      expect(controller.nationalNumber, '501234567');
      expect(controller.fullNumber, '+971501234567');
    });
    
    test('USA numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+12125551234');
      expect(controller.nationalNumber, '2125551234');
      expect(controller.fullNumber, '+12125551234');
      expect(controller.isValid, true);
      
      controller.setFullNumber('2125551234');
      expect(controller.nationalNumber, '2125551234');
      expect(controller.fullNumber, '+12125551234');
    });
    
    test('UK numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+447911123456');
      expect(controller.nationalNumber, '7911123456');
      expect(controller.fullNumber, '+447911123456');
      expect(controller.isValid, true);
      
      controller.setFullNumber('07911123456');
      expect(controller.nationalNumber, '7911123456');
      expect(controller.fullNumber, '+447911123456');
    });
    
    test('Germany numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+4915112345678');
      expect(controller.nationalNumber, '15112345678');
      expect(controller.fullNumber, '+4915112345678');
      expect(controller.isValid, true);
      
      controller.setFullNumber('015112345678');
      expect(controller.nationalNumber, '15112345678');
      expect(controller.fullNumber, '+4915112345678');
    });
    
    test('France numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+33612345678');
      expect(controller.nationalNumber, '612345678');
      expect(controller.fullNumber, '+33612345678');
      expect(controller.isValid, true);
      
      controller.setFullNumber('0612345678');
      expect(controller.nationalNumber, '612345678');
      expect(controller.fullNumber, '+33612345678');
    });
    
    test('Kuwait numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+96551234567');
      expect(controller.nationalNumber, '51234567');
      expect(controller.fullNumber, '+96551234567');
      expect(controller.isValid, true);
      
      controller.setFullNumber('51234567');
      expect(controller.nationalNumber, '51234567');
      expect(controller.fullNumber, '+96551234567');
    });
    
    test('Jordan numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+962791234567');
      expect(controller.nationalNumber, '791234567');
      expect(controller.fullNumber, '+962791234567');
      expect(controller.isValid, true);
      
      controller.setFullNumber('0791234567');
      expect(controller.nationalNumber, '791234567');
      expect(controller.fullNumber, '+962791234567');
    });
    
    test('Morocco numbers should work correctly', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+212612345678');
      expect(controller.nationalNumber, '612345678');
      expect(controller.fullNumber, '+212612345678');
      expect(controller.isValid, true);
      
      controller.setFullNumber('0612345678');
      expect(controller.nationalNumber, '612345678');
      expect(controller.fullNumber, '+212612345678');
    });
    
    test('Invalid numbers should be rejected', () {
      final controller = SmartPhoneController();
      
      controller.setFullNumber('+20123');
      expect(controller.isValid, false);
      
      controller.setFullNumber('123');
      expect(controller.isValid, false);
      
      controller.setFullNumber('');
      expect(controller.isValid, false);
    });
    
    test('Setting country manually should work', () async {
      final controller = SmartPhoneController(initialNumber: '501234567');
      
      const saudiCountry = ParserCountry(
        name: 'Saudi Arabia',
        isoCode: 'SA',
        phoneCode: '966',
        flagEmoji: '🇸🇦',
      );
      
      controller.setCountry(saudiCountry);
      expect(controller.fullNumber, '+966501234567');
      expect(controller.isValid, true);
    });
  });
}