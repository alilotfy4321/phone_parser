import 'package:flutter/material.dart';
import 'package:smart_phone_parser/src/data/country_registry.dart';
import '../models/parser_country.dart';

enum CountryPickerType {
  bottomSheet,
  dialog,
}

Future<ParserCountry?> showSmartCountryPicker({
  required BuildContext context,
  CountryPickerType type = CountryPickerType.bottomSheet,
  List<String> favoriteCountries = const [],
  ParserCountry? selectedCountry,
}) async {
  switch (type) {
    case CountryPickerType.bottomSheet:
      return await showModalBottomSheet<ParserCountry>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext sheetContext) {
          return CountryBottomSheet(
            favoriteCountries: favoriteCountries,
            selectedCountry: selectedCountry,
            onCountrySelected: (country) {
              Navigator.pop(sheetContext, country);
            },
          );
        },
      );
      
    case CountryPickerType.dialog:
      return await showDialog<ParserCountry>(
        context: context,
        builder: (BuildContext dialogContext) {
          return CountryDialog(
            favoriteCountries: favoriteCountries,
            selectedCountry: selectedCountry,
            onCountrySelected: (country) {
              Navigator.pop(dialogContext, country);
            },
          );
        },
      );
  }
}

// ==================== Bottom Sheet Widget ====================

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
  List<ParserCountry> _otherCountries = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _searchController.addListener(_filterCountries);
  }

  void _loadCountries() {
    // قائمة الدول المفضلة الافتراضية (مصر والسعودية)
    final defaultFavorites = ['EG', 'SA'];
    
    // دمج المفضلة الافتراضية مع المفضلة المرسلة
    final allFavorites = <String>[];
    allFavorites.addAll(defaultFavorites);
    allFavorites.addAll(widget.favoriteCountries);
    
    // إزالة التكرار
    final uniqueFavorites = allFavorites.toSet().toList();
    
    // تحميل الدول المفضلة
    _favoriteCountries = [];
    for (final iso in uniqueFavorites) {
      try {
        final country = allCountries.firstWhere((c) => c.isoCode == iso);
        _favoriteCountries.add(country);
      } catch (e) {
        // Country not found
      }
    }
    
    // تحميل باقي الدول
    _otherCountries = allCountries.where((c) => !_favoriteCountries.contains(c)).toList();
    _filteredCountries = _otherCountries;
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = _otherCountries;
      } else {
        _filteredCountries = _otherCountries.where((country) {
          return country.name.toLowerCase().contains(query) ||
              country.isoCode.toLowerCase().contains(query) ||
              country.phoneCode.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSearching = _searchController.text.isNotEmpty;
    
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
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Search country...',
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
            child: isSearching
                ? _buildSearchResults(theme)
                : _buildFullList(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildFullList(ThemeData theme) {
    return ListView(
      children: [
        // Favorites section
        if (_favoriteCountries.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FAVORITES',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              ..._favoriteCountries.map((country) => _buildCountryTile(country, theme)),
              // Divider between favorites and all countries
              const Divider(thickness: 1, height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ALL COUNTRIES',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.hintColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        // All countries
        ..._otherCountries.map((country) => _buildCountryTile(country, theme)),
      ],
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    if (_filteredCountries.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('No countries found'),
          ],
        ),
      );
    }
    
    return ListView(
      children: _filteredCountries.map((country) => _buildCountryTile(country, theme)).toList(),
    );
  }

  Widget _buildCountryTile(ParserCountry country, ThemeData theme) {
    return ListTile(
      leading: Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
      title: Text(country.name),
      trailing: Text('+${country.phoneCode}', style: TextStyle(color: theme.hintColor)),
      selected: widget.selectedCountry?.isoCode == country.isoCode,
      selectedTileColor: theme.primaryColor.withOpacity(0.1),
      onTap: () {
        widget.onCountrySelected(country);
      },
    );
  }
}

// ==================== Dialog Widget ====================

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
  List<ParserCountry> _favoriteCountries = [];
  List<ParserCountry> _otherCountries = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _searchController.addListener(_filterCountries);
  }

  void _loadCountries() {
    // قائمة الدول المفضلة الافتراضية (مصر والسعودية)
    final defaultFavorites = ['EG', 'SA'];
    
    // دمج المفضلة الافتراضية مع المفضلة المرسلة
    final allFavorites = <String>[];
    allFavorites.addAll(defaultFavorites);
    allFavorites.addAll(widget.favoriteCountries);
    
    // إزالة التكرار
    final uniqueFavorites = allFavorites.toSet().toList();
    
    // تحميل الدول المفضلة
    _favoriteCountries = [];
    for (final iso in uniqueFavorites) {
      try {
        final country = allCountries.firstWhere((c) => c.isoCode == iso);
        _favoriteCountries.add(country);
      } catch (e) {
        // Country not found
      }
    }
    
    // تحميل باقي الدول
    _otherCountries = allCountries.where((c) => !_favoriteCountries.contains(c)).toList();
    _filteredCountries = _otherCountries;
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = _otherCountries;
      } else {
        _filteredCountries = _otherCountries.where((country) {
          return country.name.toLowerCase().contains(query) ||
              country.isoCode.toLowerCase().contains(query) ||
              country.phoneCode.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCountries);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSearching = _searchController.text.isNotEmpty;
    
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
            TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search country...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isSearching
                  ? _buildSearchResults(theme)
                  : _buildFullList(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullList(ThemeData theme) {
    return ListView(
      children: [
        if (_favoriteCountries.isNotEmpty)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FAVORITES',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              ..._favoriteCountries.map((country) => _buildCountryTile(country, theme)),
              const Divider(thickness: 1, height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ALL COUNTRIES',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.hintColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ..._otherCountries.map((country) => _buildCountryTile(country, theme)),
      ],
    );
  }

  Widget _buildSearchResults(ThemeData theme) {
    if (_filteredCountries.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey),
            SizedBox(height: 8),
            Text('No countries found'),
          ],
        ),
      );
    }
    
    return ListView(
      children: _filteredCountries.map((country) => _buildCountryTile(country, theme)).toList(),
    );
  }

  Widget _buildCountryTile(ParserCountry country, ThemeData theme) {
    return ListTile(
      leading: Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
      title: Text(country.name),
      trailing: Text('+${country.phoneCode}', style: TextStyle(color: theme.hintColor)),
      selected: widget.selectedCountry?.isoCode == country.isoCode,
      selectedTileColor: theme.primaryColor.withOpacity(0.1),
      onTap: () {
        widget.onCountrySelected(country);
      },
    );
  }
}