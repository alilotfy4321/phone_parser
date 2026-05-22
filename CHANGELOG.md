# Changelog

## 1.0.0 - 2026-05-22

### Added

- Initial release of Smart Phone Parser
- Automatic country detection from phone numbers
- Country registry with 100+ countries and territories
- PhoneParserBuilder widget with default Material Design layout
- Custom UI builder pattern for complete layout control
- PhoneParserController for state management
- Real-time parsing as user types
- Flag emoji support for all countries
- E.164 format output
- Form validation support
- Country search bottom sheet
- Support for international format with '+' prefix
- Support for double-zero (00) prefix
- Automatic trunk zero removal
- Fallback country code support

### Features

- PhoneParserEngine core parsing logic
- ParsedPhone immutable data model
- CountryRegistry with O(1) lookups
- Customizable border radius, colors, and styling
- Text input formatting (digits only)

### Technical

- Built with Flutter 3.0+
- Supports Dart SDK 3.0+
- Null safety
- Platform independent
