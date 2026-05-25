
import 'package:flutter/material.dart';
import '../models/parser_country.dart';

/// Individual country tile for the picker
class CountryTile extends StatelessWidget {
  final ParserCountry country;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showPhoneCode;

  const CountryTile({
    super.key,
    required this.country,
    required this.isSelected,
    required this.onTap,
    this.showPhoneCode = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ListTile(
      leading: Text(
        country.flagEmoji,
        style: const TextStyle(fontSize: 28),
      ),
      title: Text(
        country.name,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: showPhoneCode
          ? Text(
              '+${country.phoneCode}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.hintColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          : isSelected
              ? Icon(Icons.check_circle, color: theme.primaryColor, size: 20)
              : null,
      selected: isSelected,
      onTap: onTap,
    );
  }
}