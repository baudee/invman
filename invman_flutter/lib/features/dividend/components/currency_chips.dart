import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';

class CurrencyChips extends StatelessWidget {
  final List<String> currencies;
  final String? selected;
  final void Function(String) onSelect;

  const CurrencyChips({super.key, required this.currencies, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: currencies.map((c) {
          return Padding(
            padding: const EdgeInsets.only(right: UIConstants.spacingSm),
            child: FilterChip(
              label: Text(c),
              selected: c == selected,
              onSelected: (_) => onSelect(c),
            ),
          );
        }).toList(),
      ),
    );
  }
}
