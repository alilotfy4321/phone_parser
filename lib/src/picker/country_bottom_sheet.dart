import 'package:flutter/material.dart';
import 'package:smart_phone_parser/src/data/country_registry.dart';
import '../models/parser_country.dart';

class CountryBottomSheet extends StatefulWidget {
  final List<String> favoriteCountries;
  final ParserCountry? selectedCountry;
  final ValueChanged<ParserCountry> onCountrySelected;

  const CountryBottomSheet({
    super.key,
    required this.favoriteCountries,
    this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<ParserCountry> _filteredCountries = [];
  List<ParserCountry> _favoriteCountries = [];

  @override
  void initState() {
    super.initState();
    _filteredCountries = allCountries;
    _loadFavorites();
    _searchController.addListener(_onSearchChanged);
  }

  void _loadFavorites() {
    if (widget.favoriteCountries.isNotEmpty) {
      _favoriteCountries = [];
      for (final iso in widget.favoriteCountries) {
        try {
          final country = allCountries.firstWhere(
            (c) => c.isoCode == iso,
          );
          _favoriteCountries.add(country);
        } catch (e) {
          // Country not found, skip
        }
      }
    }
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select Country',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Search field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search by country name or dial code...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Country list
          Expanded(
            child: _filteredCountries.isEmpty
                ? const Center(child: Text('No countries found'))
                : ListView.builder(
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = _filteredCountries[index];
                      final isFavorite = _favoriteCountries.contains(country);
                      
                      return Column(
                        children: [
                          if (isFavorite && index == 0 && _searchController.text.isEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'FAVORITES',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ListTile(
                            leading: Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
                            title: Text(country.name),
                            trailing: Text('+${country.phoneCode}'),
                            onTap: () {
                              // إغلاق الـ Bottom Sheet أولاً
                              Navigator.pop(context);
                              // ثم استدعاء الـ callback
                              widget.onCountrySelected(country);
                            },
                          ),
                        ],
                      );
                    },
                  ),
          ),
          SizedBox(height: bottomInset),
        ],
      ),
    );
  }
}