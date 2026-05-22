import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../engine/phone_parser_controller.dart';
import '../models/phone_model.dart';
import './country_search_sheet.dart';

typedef PhoneWidgetBuilder = Widget Function(
  BuildContext context,
  PhoneParserController controller,
  ParsedPhone status,
  VoidCallback showCountrySelector,
);

class PhoneParserBuilder extends StatefulWidget {
  final PhoneParserController controller;
  final PhoneWidgetBuilder? builder;

  // Configuration properties for the default form field layout
  final String? hintText;
  final String? labelText;
  final double radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final BoxBorder? customContainerBorder;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? countryCodeStyle;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator; // Added for native Form validation support

  const PhoneParserBuilder({
    super.key,
    required this.controller,
    this.builder,
    this.hintText,
    this.labelText,
    this.radius = 12.0,
    this.backgroundColor,
    this.borderColor,
    this.customContainerBorder,
    this.textStyle,
    this.hintStyle,
    this.countryCodeStyle,
    this.contentPadding,
    this.validator,
  });

  @override
  State<PhoneParserBuilder> createState() => _PhoneParserBuilderState();
}

class _PhoneParserBuilderState extends State<PhoneParserBuilder> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleStateUpdates);
  }

  @override
  void didUpdateWidget(covariant PhoneParserBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Safely migrate listeners if the controller instance changes across widget rebuilds
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_handleStateUpdates);
      widget.controller.addListener(_handleStateUpdates);
    }
  }

  void _handleStateUpdates() {
    if (mounted) setState(() {});
  }

  void _triggerSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true, // Guarantees layout clearance for system notches/status bars
      backgroundColor: Colors.transparent,
      builder: (context) => CountrySearchSheet(
        onCountrySelected: (contract) {
          // Syncs flawlessly with the PickedCountryContract type-safe architecture
          widget.controller.setCountry(contract);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If the consumer provided a custom builder, delegate rendering entirely
    if (widget.builder != null) {
      return widget.builder!(
        context,
        widget.controller,
        widget.controller.value,
        _triggerSearchModal,
      );
    }

    final theme = Theme.of(context);
    final status = widget.controller.value;
    final borderRadius = BorderRadius.circular(widget.radius);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: widget.textStyle ?? const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6.0),
        ],
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? theme.cardColor,
            borderRadius: borderRadius,
            border: widget.customContainerBorder ?? Border.all(
              color: widget.borderColor ?? theme.dividerColor,
              width: 1.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Country Selector Interactive Block
              InkWell(
                onTap: _triggerSearchModal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.radius),
                  bottomLeft: Radius.circular(widget.radius),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        status.flagEmoji,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '+${status.countryCode}',
                        style: widget.countryCodeStyle ?? const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 22.0,
                        color: theme.hintColor,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Custom separator segment
              Container(
                height: 22.0,
                width: 1.0,
                color: widget.borderColor ?? theme.dividerColor.withAlpha(128),
              ),

              // National Input Input Component Area
              Expanded(
                child: TextFormField(
                  controller: widget.controller.textController,
                  keyboardType: TextInputType.phone,
                  style: widget.textStyle ?? const TextStyle(fontSize: 14.0),
                  validator: widget.validator,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? 'Enter phone number',
                    hintStyle: widget.hintStyle ?? TextStyle(color: theme.hintColor, fontSize: 14.0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleStateUpdates);
    super.dispose();
  }
}