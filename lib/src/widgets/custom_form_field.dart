import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

/// A fully customizable phone number input field with country code selector
class CustomSmartPhoneField extends StatelessWidget {
  final PhoneParserController controller;
  final VoidCallback? onCountryTap;
  final ValueChanged<String>? onCountryCodeChanged;
  final ValueChanged<String>? onPhoneNumberChanged;
  final ValueChanged<ParsedPhone>? onPhoneParsed;
  
  // Text configuration
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  
  // Design Layout Overrides
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? activeBorderColor;
  final BoxBorder? customContainerBorder;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  
  // Typography
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final TextStyle? countryCodeStyle;
  final TextStyle? flagStyle;
  
  // Behavior
  final bool enabled;
  final bool showFlag;
  final bool showDropdownIcon;
  final bool showSplitBar;
  final bool autoFocus;
  final bool readOnly;
  final bool obscureText;
  
  // Validation
  final FormFieldValidator<String>? validator;
  final AutovalidateMode autovalidateMode;
  
  // Callbacks
  final void Function(bool)? onFocusChange;
  final void Function(String)? onFieldSubmitted;
  
  // Other
  final FocusNode? focusNode;
  final List<TextInputFormatter>? additionalInputFormatters;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;
  
  // Country selector customization
  final Widget? countrySelectorPrefix;
  final double countrySelectorMinWidth;
  final double splitBarHeight;
  final double splitBarWidth;
  
  // Animation
  final Duration animationDuration;
  final Curve animationCurve;

  const CustomSmartPhoneField({
    super.key,
    required this.controller,
    this.onCountryTap,
    this.onCountryCodeChanged,
    this.onPhoneNumberChanged,
    this.onPhoneParsed,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.radius = 12.0,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.activeBorderColor,
    this.customContainerBorder,
    this.padding,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.countryCodeStyle,
    this.flagStyle,
    this.enabled = true,
    this.showFlag = true,
    this.showDropdownIcon = true,
    this.showSplitBar = true,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscureText = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onFocusChange,
    this.onFieldSubmitted,
    this.focusNode,
    this.additionalInputFormatters,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.countrySelectorPrefix,
    this.countrySelectorMinWidth = 100.0,
    this.splitBarHeight = 22.0,
    this.splitBarWidth = 1.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(radius);
    
    return PhoneParserBuilder(
      controller: controller,
      builder: (context, activeController, status, showCountrySelector) {
        // Notify country code changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onCountryCodeChanged?.call(status.countryCode);
          onPhoneNumberChanged?.call(status.nationalNumber);
          onPhoneParsed?.call(status);
        });
        
        return AnimatedContainer(
          duration: animationDuration,
          curve: animationCurve,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Label with validation indicator
              if (labelText != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        labelText!,
                        style: labelStyle ??
                            theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: enabled ? null : theme.disabledColor,
                            ),
                      ),
                    ),
                    if (validator != null)
                      ValueListenableBuilder<ParsedPhone>(
                        valueListenable: controller,
                        builder: (context, phoneModel, _) {
                          final isValid = phoneModel.isValid;
                          return AnimatedOpacity(
                            duration: animationDuration,
                            opacity: phoneModel.nationalNumber.isNotEmpty ? 1.0 : 0.0,
                            child: Icon(
                              isValid ? Icons.check_circle : Icons.error,
                              size: 16,
                              color: isValid ? Colors.green : Colors.red,
                            ),
                          );
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 6.0),
              ],
              
              // Helper text
              if (helperText != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    helperText!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              
              // Main input container
              Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: backgroundColor ?? theme.cardColor,
                  borderRadius: borderRadius,
                  border: customContainerBorder ??
                      _buildBorder(theme, status.isValid),
                ),
                child: Row(
                  children: [
                    // Country Selector Section
                    _buildCountrySelector(
                      context,
                      status,
                      showCountrySelector,
                      borderRadius,
                    ),
                    
                    // Split Bar
                    if (showSplitBar)
                      Container(
                        height: splitBarHeight,
                        width: splitBarWidth,
                        color: borderColor ??
                            theme.dividerColor.withValues(alpha: 0.5),
                      ),
                    
                    // Phone Number Input Section
                    Expanded(
                      child: _buildPhoneNumberInput(
                        context,
                        activeController,
                        theme,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Error text
              if (errorText != null || validator != null)
                ValueListenableBuilder<ParsedPhone>(
                  valueListenable: controller,
                  builder: (context, phoneModel, _) {
                    String? error;
                    if (errorText != null) {
                      error = errorText;
                    } else if (validator != null && phoneModel.nationalNumber.isNotEmpty) {
                      error = validator!(phoneModel.nationalNumber);
                    }
                    
                    if (error == null) return const SizedBox.shrink();
                    
                    return Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        error,
                        style: errorStyle ??
                            theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                              fontSize: 12,
                            ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountrySelector(
    BuildContext context,
    ParsedPhone status,
    VoidCallback showCountrySelector,
    BorderRadius borderRadius,
  ) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: enabled ? (onCountryTap ?? showCountrySelector) : null,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
      ),
      child: Container(
        constraints: BoxConstraints(minWidth: countrySelectorMinWidth),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: countrySelectorPrefix != null
              ? [countrySelectorPrefix!]
              : [
                  // Flag emoji
                  if (showFlag) ...[
                    AnimatedSwitcher(
                      duration: animationDuration,
                      child: Text(
                        status.flagEmoji,
                        key: ValueKey(status.flagEmoji),
                        style: flagStyle ??
                            const TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                  ],
                  
                  // Country code
                  AnimatedSwitcher(
                    duration: animationDuration,
                    child: Text(
                      '+${status.countryCode}',
                      key: ValueKey(status.countryCode),
                      style: countryCodeStyle ??
                          theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: enabled ? null : theme.disabledColor,
                          ),
                    ),
                  ),
                  
                  // Dropdown icon
                  if (showDropdownIcon && enabled) ...[
                    const SizedBox(width: 2.0),
                    AnimatedRotation(
                      duration: animationDuration,
                      turns: 0,
                      child: Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 22.0,
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput(
    BuildContext context,
    PhoneParserController activeController,
    ThemeData theme,
  ) {
    final inputFormatters = <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
      if (additionalInputFormatters != null) ...additionalInputFormatters!,
    ];
    
    return TextFormField(
      controller: activeController.textController,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      style: textStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.0,
            color: enabled ? null : theme.disabledColor,
          ),
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      autofocus: autoFocus,
      textInputAction: textInputAction,
      maxLines: maxLines,
      maxLength: maxLength,
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
      inputFormatters: inputFormatters,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (value) {
        onPhoneNumberChanged?.call(value);
      },
      decoration: InputDecoration(
        hintText: hintText ?? 'Enter phone number',
        hintStyle: hintStyle ??
            theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
              fontSize: 14.0,
            ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        isDense: true,
      ),
    );
  }

  BoxBorder _buildBorder(ThemeData theme, bool isValid) {
    Color borderColorValue;
    
    if (!enabled) {
      borderColorValue = theme.disabledColor;
    } else if (errorText != null || (validator != null && !isValid)) {
      borderColorValue = errorBorderColor ?? theme.colorScheme.error;
    } else if (focusNode?.hasFocus ?? false) {
      borderColorValue = focusedBorderColor ?? theme.primaryColor;
    } else {
      borderColorValue = borderColor ?? theme.dividerColor;
    }
    
    return Border.all(
      color: borderColorValue,
      width: (focusNode?.hasFocus ?? false) ? 2.0 : 1.0,
    );
  }
}