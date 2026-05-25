
/// Represents a country with its phone dialing information
class ParserCountry {
  final String name;
  final String isoCode;
  final String phoneCode;
  final String flagEmoji;

  const ParserCountry({
    required this.name,
    required this.isoCode,
    required this.phoneCode,
    required this.flagEmoji,
  });

  /// Returns the full dial string including the plus sign
  String get dialCode => '+$phoneCode';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParserCountry &&
          runtimeType == other.runtimeType &&
          isoCode == other.isoCode;

  @override
  int get hashCode => isoCode.hashCode;

  @override
  String toString() => '$name ($isoCode) +$phoneCode';
}