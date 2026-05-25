import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/smart_phone_controller.dart';
import '../models/parser_country.dart';
import '../models/parsed_phone.dart';
import '../picker/country_picker.dart';
import '../theme/smart_phone_theme.dart';

class SmartPhoneField extends StatelessWidget {
  // Required (Only controller is required)
  final SmartPhoneController controller;

  // Optional - Picker Configuration
  final CountryPickerType? pickerType;
  final List<String>? favoriteCountries;

  // Optional - UI Configuration
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool? enabled;
  final bool? readOnly;
  final bool? autoFocus;

  // Optional - Callbacks
  final ValueChanged<ParsedPhone>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onCountryTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;

  // Optional - Styling
  final SmartPhoneTheme? theme;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Optional - InputDecoration properties
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final bool? filled;
  final Color? fillColor;

  // Optional - Country Builder
  final Widget Function(
    BuildContext context,
    ParserCountry country,
    VoidCallback openPicker,
  )? countryBuilder;

  // Custom builder
  final Widget Function(
    BuildContext context,
    SmartPhoneController controller,
    ParsedPhone phone,
    VoidCallback openCountryPicker,
  )? customBuilder;

  // Constructor with all optional parameters except controller
  const SmartPhoneField({
    super.key,
    required this.controller,
    this.pickerType,
    this.favoriteCountries,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.enabled,
    this.readOnly,
    this.autoFocus,
    this.onChanged,
    this.validator,
    this.onCountryTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.theme,
    this.focusNode,
    this.textInputAction,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.filled,
    this.fillColor,
    this.countryBuilder,
    this.customBuilder,
  });

  // Custom builder constructor
  const SmartPhoneField.custom({
    super.key,
    required this.controller,
    required Widget Function(
      BuildContext context,
      SmartPhoneController controller,
      ParsedPhone phone,
      VoidCallback openCountryPicker,
    ) builder,
    this.pickerType,
    this.favoriteCountries,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.enabled,
    this.readOnly,
    this.autoFocus,
    this.onChanged,
    this.validator,
    this.onCountryTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.theme,
    this.focusNode,
    this.textInputAction,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.helperStyle,
    this.filled,
    this.fillColor,
    this.countryBuilder,
  }) : customBuilder = builder;

  @override
  Widget build(BuildContext context) {
    if (customBuilder != null) {
      return ValueListenableBuilder<ParsedPhone>(
        valueListenable: controller,
        builder: (context, phone, _) {
          return customBuilder!(
            context,
            controller,
            phone,
            () => _openPicker(context),
          );
        },
      );
    }

    return _buildDefaultField(context);
  }

  Widget _buildDefaultField(BuildContext context) {
    final effectiveTheme = theme ??
        (Theme.of(context).brightness == Brightness.dark
            ? SmartPhoneTheme.dark
            : SmartPhoneTheme.light);
    final isEnabled = enabled ?? true;
    final isReadOnly = readOnly ?? false;
    final isAutoFocus = autoFocus ?? false;

    return ValueListenableBuilder<ParsedPhone>(
      valueListenable: controller,
      builder: (context, phone, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  labelText!,
                  style: labelStyle ?? effectiveTheme.labelStyle,
                ),
              ),
            if (helperText != null && helperText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  helperText!,
                  style: helperStyle ?? effectiveTheme.hintStyle,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                color: fillColor ?? effectiveTheme.backgroundColor,
                borderRadius: effectiveTheme.borderRadius,
                border: _buildBorder(effectiveTheme, phone.isValid),
              ),
              child: Row(
                children: [
                  if (prefixIcon != null)
                    Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: prefixIcon),
                  if (countryBuilder != null)
                    countryBuilder!(
                        context, phone.country, () => _openPicker(context))
                  else
                    _buildCountrySelector(
                        context, effectiveTheme, phone, isEnabled),
                  Container(
                    height: effectiveTheme.splitBarHeight,
                    width: effectiveTheme.splitBarWidth,
                    color: effectiveTheme.borderColor,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.textController,
                      focusNode: focusNode,
                      enabled: isEnabled,
                      readOnly: isReadOnly,
                      autofocus: isAutoFocus,
                      textInputAction: textInputAction,
                      keyboardType: TextInputType.phone,
                      style: effectiveTheme.inputStyle ??
                          Theme.of(context).textTheme.bodyMedium,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) => onChanged?.call(controller.phone),
                      onEditingComplete: onEditingComplete,
                      onFieldSubmitted: onFieldSubmitted,
                      validator: (value) {
                        if (validator != null) return validator!(value);
                        if (value != null &&
                            value.isNotEmpty &&
                            !controller.isValid) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: hintText ?? 'Enter phone number',
                        hintStyle: hintStyle ?? effectiveTheme.hintStyle,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding:
                            contentPadding ?? effectiveTheme.contentPadding,
                        isDense: true,
                      ),
                    ),
                  ),
                  if (suffixIcon != null)
                    Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: suffixIcon),
                ],
              ),
            ),
            if (errorText != null || validator != null)
              _buildErrorText(phone, effectiveTheme, context),
          ],
        );
      },
    );
  }

  Widget _buildCountrySelector(
    BuildContext context,
    SmartPhoneTheme theme,
    ParsedPhone phone,
    bool isEnabled,
  ) {
    return InkWell(
      onTap: isEnabled ? (onCountryTap ?? () => _openPicker(context)) : null,
      borderRadius: BorderRadius.only(
        topLeft: theme.borderRadius.topLeft,
        bottomLeft: theme.borderRadius.bottomLeft,
      ),
      child: Container(
        padding: contentPadding ?? theme.contentPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              phone.flagEmoji,
              style: TextStyle(fontSize: theme.flagSize),
            ),
            const SizedBox(width: 8),
            Text(
              phone.dialCode,
              style: theme.countryCodeStyle ??
                  const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            if (isEnabled)
              Icon(
                Icons.arrow_drop_down,
                size: 20,
                color: Theme.of(context).hintColor,
              ),
          ],
        ),
      ),
    );
  }

  BoxBorder _buildBorder(SmartPhoneTheme theme, bool isValid) {
    final borderColor = _getBorderColor(theme, isValid);
    final borderWidth = (focusNode?.hasFocus == true) ? 2.0 : 1.0;
    return Border.all(color: borderColor, width: borderWidth);
  }

  Widget _buildErrorText(
      ParsedPhone phone, SmartPhoneTheme theme, BuildContext context) {
    String? error = errorText;
    if (error == null && validator != null && phone.nationalNumber.isNotEmpty) {
      error = validator!(phone.nationalNumber);
    }
    if (error == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        error,
        style: errorStyle ??
            theme.errorStyle ??
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
      ),
    );
  }

  Color _getBorderColor(SmartPhoneTheme theme, bool isValid) {
    final isEnabled = enabled ?? true;
    if (!isEnabled) return Colors.grey.shade300;

    final hasError = (errorText != null) ||
        (validator != null && controller.nationalNumber.isNotEmpty && !isValid);
    if (hasError) return theme.errorBorderColor;

    if (focusNode?.hasFocus == true) return theme.focusedBorderColor;

    return theme.borderColor;
  }

  void _openPicker(BuildContext context) async {
    final selectedCountry = await showSmartCountryPicker(
      context: context,
      type: pickerType ?? CountryPickerType.bottomSheet,
      favoriteCountries: favoriteCountries ?? const [],
      selectedCountry: controller.country,
    );

    if (selectedCountry != null) {
      controller.setCountry(selectedCountry);
    }
  }
}
