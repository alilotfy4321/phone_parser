import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';
import 'package:smart_phone_parser/src/engine/phone_parser_engine.dart';

// موك كلاس بسيط عشان يطابق الـ dynamic country اللي الكنترولر بيقراه
class MockCountry {
  final String name;
  final String isoCode;
  final String dialCode;
  final String flag;

  const MockCountry({
    required this.name,
    required this.isoCode,
    required this.dialCode,
    required this.flag,
  });
}

void main() {
  group('PhoneParserEngine Unit Tests', () {
    test('Should cleanly extract digits and remove non-numeric visual clutter', () {
      expect(PhoneParserEngine.extractDigits('+20 123-456 789'), '20123456789');
      expect(PhoneParserEngine.extractDigits('(050) 123 456'), '050123456');
    });

    test(
      'Should auto-detect explicitly typed international prefix with plus (+)',
      () {
        final result = PhoneParserEngine.parse(input: '+966501234567');
        expect(result.countryCode, '966');
        expect(result.isoCode, 'SA');
        expect(result.countryName, 'Saudi Arabia');
        expect(result.nationalNumber, '501234567');
        expect(result.fullNumber, '+966501234567');
      },
    );

    test(
      'Should auto-detect international prefix typed with double zero (00)',
      () {
        final result = PhoneParserEngine.parse(input: '00971501234567');
        expect(result.countryCode, '971');
        expect(result.isoCode, 'AE');
        expect(result.nationalNumber, '501234567');
      },
    );

    test(
      'Should utilize fallback code and drop leading trunk zero for local entries',
      () {
        final result = PhoneParserEngine.parse(
          input: '01012345678',
          fallbackCode: '20',
        );
        expect(result.countryCode, '20');
        expect(result.isoCode, 'EG');
        expect(result.nationalNumber, '1012345678'); // Leading 0 stripped
        expect(result.fullNumber, '+201012345678');
      },
    );
  });

  group('PhoneParserController Tests', () {
    test('Should update reactive state when textController value changes', () {
      final controller = PhoneParserController();

      controller.textController.text = '01112345678';
      // ملاحظة: لو الـ Parser بتاعك شغال داخلياً هيعمل strip للـ 0 برضه
      expect(controller.value.countryCode, '20');

      controller.dispose();
    });

    test(
      'Should immediately re-parse state when target country is manually updated',
      () {
        final controller = PhoneParserController(
          initialText: '501234567',
        );

        // عملنا الموك هنا بنفس الـ properties اللي الكنترولر بيقراها في الـ updateCountry
        final saudiMock = MockCountry(
          name: 'Saudi Arabia',
          isoCode: 'SA',
          dialCode: '966',
          flag: '🇸🇦',
        );
        controller.setCountry(saudiMock as PickedCountryContract);

        // بنقرا الداتا مباشرة من الـ value بعد التعديل النظيف
        expect(controller.value.countryCode, '966');
        expect(controller.value.flagEmoji, '🇸🇦');
        expect(controller.value.isoCode, 'SA');
        expect(controller.value.countryName, 'Saudi Arabia');
        expect(controller.value.fullNumber, '+966501234567');

        controller.dispose();
      },
    );

    // ─── تيست جديد عشان نضمن إن الداتا مبيحصلهاش رمشة أو بتتمسح لو الفيلد فضي ───
    test(
      'Should preserve active country profile details when text field becomes empty',
      () {
        final controller = PhoneParserController(
          initialText: '1012345678',
        );

        // بنمسح التكست خالص
        controller.textController.text = '';

        // بنتأكد إن الداتا متمسحتش وبقت الفيلدز الفاضية '' زي زمان
        expect(controller.value.countryCode, '20');
        expect(controller.value.flagEmoji, '🇪🇬');
        expect(controller.value.isoCode, 'EG');
        expect(controller.value.countryName, 'Egypt');
        expect(controller.value.nationalNumber, '');

        controller.dispose();
      },
    );
  });

  group('PhoneParserBuilder Widget Tests', () {
    testWidgets(
      'Should dynamically render inner widgets using the custom functional builder pipeline',
      (WidgetTester tester) async {
        final controller = PhoneParserController(
          initialText: '1012345678',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PhoneParserBuilder(
                controller: controller,
                builder: (context, ctrl, status, showCountrySelector) {
                  // بنقرأ من الكنترولر مباشرة زي ما عدلنا في الـ Showcase عشان نضمن الثبات
                  final currentState = ctrl.value;
                  return Column(
                    children: [
                      Text(
                        'Country: ${currentState.countryName}',
                        key: const Key('country_text'),
                      ),
                      Text(
                        'National: ${currentState.nationalNumber}',
                        key: const Key('national_text'),
                      ),
                      Text(
                        'E164: ${currentState.fullNumber}',
                        key: const Key('e164_text'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        // نتأكد إن الـ UI رندر الداتا المبدئية صحيحة
        expect(find.text('Country: Egypt'), findsOneWidget);

        controller.dispose();
      },
    );
  });
}
