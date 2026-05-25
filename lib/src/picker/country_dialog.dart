import 'package:flutter/material.dart';
import 'package:smart_phone_parser/src/data/country_registry.dart';
import '../models/parser_country.dart';
import 'country_search_field.dart';

class CountryDialog extends StatefulWidget {
  final List<String> favoriteCountries;
  final ParserCountry? selectedCountry;
  final ValueChanged<ParserCountry> onCountrySelected;

  const CountryDialog({
    super.key,
    required this.favoriteCountries,
    this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountryDialog> createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<ParserCountry> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = allCountries;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = allCountries;
      } else {
        _filteredCountries = allCountries.where((country) {
          return country.name.toLowerCase().contains(query.toLowerCase()) ||
              country.isoCode.toLowerCase().contains(query.toLowerCase()) ||
              country.phoneCode.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Select Country',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            CountrySearchField(
              controller: _searchController,
              hintText: 'Search by country name or dial code...',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredCountries.isEmpty
                  ? const Center(child: Text('No countries found'))
                  : ListView.builder(
                      itemCount: _filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = _filteredCountries[index];
                        return ListTile(
                          leading: Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
                          title: Text(country.name),
                          trailing: Text('+${country.phoneCode}'),
                          selected: widget.selectedCountry?.isoCode == country.isoCode,
                          onTap: () {
                            widget.onCountrySelected(country);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}