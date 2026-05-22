import 'package:flutter/material.dart';
import '../data/country_registry.dart';

class CountrySearchSheet extends StatefulWidget {
  final ValueChanged<ParserCountry> onCountrySelected;

  const CountrySearchSheet({
    super.key,
    required this.onCountrySelected,
  });

  @override
  State<CountrySearchSheet> createState() => _CountrySearchSheetState();
}

class _CountrySearchSheetState extends State<CountrySearchSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<ParserCountry> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    // Initialize state cleanly with full array references
    _filteredCountries = CountryRegistry.countries;
    _searchController.addListener(_performSearchFilter);
  }

  void _performSearchFilter() {
    final query = _searchController.text;
    setState(() {
      _filteredCountries = CountryRegistry.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Limit bottom sheet to 75% of maximum safe layout window bounds
        final sheetTargetHeight = constraints.maxHeight * 0.75;

        return Container(
          height: sheetTargetHeight,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: bottomInset + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Standard visual sheet anchor bar indicator
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.dividerColor.withAlpha(80),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search by country name or dial code...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _filteredCountries.isEmpty
                    ? const Center(
                        child: Text(
                          'No results found.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredCountries.length,
                        // Providing itemExtent radically optimizes performance and scrolling speed
                        itemExtent: 56.0, 
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          
                          return ListTile(
                            leading: Text(
                              country.flagEmoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(
                              country.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              '+${country.phoneCode}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.disabledColor,
                              ),
                            ),
                            onTap: () {
                              // Relinquish keyboard focus immediately to bypass sheet dismissal animations stuttering
                              FocusScope.of(context).unfocus();
                              
                              widget.onCountrySelected(country);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearchFilter);
    _searchController.dispose();
    super.dispose();
  }
}