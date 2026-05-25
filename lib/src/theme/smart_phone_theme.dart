/// Location: lib/src/theme/smart_phone_theme.dart
library;

import 'package:flutter/material.dart';

/// Theme configuration for SmartPhoneField
class SmartPhoneTheme {
  final BorderRadius borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color backgroundColor;
  final TextStyle? inputStyle;
  final TextStyle? countryCodeStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry contentPadding;
  final double splitBarHeight;
  final double splitBarWidth;
  final double flagSize;

  const SmartPhoneTheme({
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.backgroundColor = Colors.white,
    this.inputStyle,
    this.countryCodeStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    this.splitBarHeight = 22,
    this.splitBarWidth = 1,
    this.flagSize = 24,
  });

  /// Default light theme
  static const SmartPhoneTheme light = SmartPhoneTheme(
    borderColor: Color(0xFFE0E0E0),
    focusedBorderColor: Color(0xFF2196F3),
    errorBorderColor: Color(0xFFF44336),
    backgroundColor: Colors.white,
  );

  /// Default dark theme
  static const SmartPhoneTheme dark = SmartPhoneTheme(
    borderColor: Color(0xFF424242),
    focusedBorderColor: Color(0xFF64B5F6),
    errorBorderColor: Color(0xFFEF5350),
    backgroundColor: Color(0xFF1E1E1E),
  );

  /// Copy with
  SmartPhoneTheme copyWith({
    BorderRadius? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? backgroundColor,
    TextStyle? inputStyle,
    TextStyle? countryCodeStyle,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    EdgeInsetsGeometry? contentPadding,
    double? splitBarHeight,
    double? splitBarWidth,
    double? flagSize,
  }) {
    return SmartPhoneTheme(
      borderRadius: borderRadius ?? this.borderRadius,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      inputStyle: inputStyle ?? this.inputStyle,
      countryCodeStyle: countryCodeStyle ?? this.countryCodeStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      contentPadding: contentPadding ?? this.contentPadding,
      splitBarHeight: splitBarHeight ?? this.splitBarHeight,
      splitBarWidth: splitBarWidth ?? this.splitBarWidth,
      flagSize: flagSize ?? this.flagSize,
    );
  }
}