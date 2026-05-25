/// Smart Phone Parser
///
/// A professional international phone number parsing and validation package for Flutter.
/// Provides automatic country detection, formatting, and a customizable widget.
///
/// ## Quick Start
///
/// ```dart
/// final controller = SmartPhoneController();
///
/// SmartPhoneField(
///   controller: controller,
/// )
/// ```
///
/// ## Profile Edit
///
/// ```dart
/// final controller = SmartPhoneController.fromFullNumber("+201234567890");
/// ```
///
/// ## With Form Validation
///
/// ```dart
/// Form(
///   child: SmartPhoneField(
///     controller: controller,
///     validator: PhoneValidator.required,
///   ),
/// )
/// ```
///
/// ## Custom Styling
///
/// ```dart
/// SmartPhoneField(
///   controller: controller,
///   theme: SmartPhoneTheme.light.copyWith(
///     borderRadius: BorderRadius.circular(30),
///     borderColor: Colors.blue,
///   ),
/// )
/// ```
library smart_phone_parser;

// Core exports - user only needs these 6 things
export 'src/controller/smart_phone_controller.dart';
export 'src/models/parsed_phone.dart';
export 'src/models/parser_country.dart';
export 'src/widgets/smart_phone_field.dart';
export 'src/parser/phone_validator.dart';
export 'src/picker/country_picker.dart';

// Optional utilities for advanced users
export 'src/parser/phone_formatter.dart';
export 'src/parser/phone_parser.dart';
export 'src/extensions/phone_extensions.dart';
export 'src/theme/smart_phone_theme.dart';
export 'src/controller/phone_rules.dart';
