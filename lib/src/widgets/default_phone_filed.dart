
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/smart_phone_controller.dart';
import '../models/parsed_phone.dart';
import '../picker/country_picker.dart';

/// Simple default phone field with minimal configuration
/// Perfect for beginners and quick implementations
class DefaultPhoneField extends StatefulWidget {
  final SmartPhoneController controller;
  final String? hintText;
  final String? labelText;
  final bool enabled;
  final ValueChanged<ParsedPhone>? onChanged;
  final FormFieldValidator<String>? validator;

  const DefaultPhoneField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.enabled = true,
    this.onChanged,
    this.validator,
  });

  @override
  State<DefaultPhoneField> createState() => _DefaultPhoneFieldState();
}

class _DefaultPhoneFieldState extends State<DefaultPhoneField> {
  final FocusNode _focusNode = FocusNode();
  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ValueListenableBuilder<ParsedPhone>(
      valueListenable: widget.controller,
      builder: (context, phone, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.labelText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  widget.labelText!,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getBorderColor(theme, phone.isValid),
                  width: _focusNode.hasFocus ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  // Country selector
                  InkWell(
                    onTap: widget.enabled ? _showCountryPicker : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      child: Row(
                        children: [
                          Text(phone.flagEmoji, style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 8),
                          Text(phone.dialCode, style: const TextStyle(fontWeight: FontWeight.bold)),
                          if (widget.enabled)
                            const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 1,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller.textController,
                      focusNode: _focusNode,
                      enabled: widget.enabled,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        setState(() {});
                        widget.onChanged?.call(widget.controller.phone);
                      },
                      validator: (value) {
                        if (widget.validator != null) {
                          return widget.validator!(value);
                        }
                        if (value != null && value.isNotEmpty && !widget.controller.isValid) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: widget.hintText ?? 'Enter phone number',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getBorderColor(ThemeData theme, bool isValid) {
    if (!widget.enabled) return Colors.grey.shade300;
    if (widget.validator != null && !isValid && widget.controller.nationalNumber.isNotEmpty) {
      return Colors.red;
    }
    if (_focusNode.hasFocus) return theme.primaryColor;
    return Colors.grey.shade400;
  }

  void _showCountryPicker() async {
    final selected = await showSmartCountryPicker(
      context: context,
      selectedCountry: widget.controller.country,
    );
    if (selected != null) {
      widget.controller.setCountry(selected);
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}