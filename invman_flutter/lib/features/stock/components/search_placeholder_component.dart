import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class StockSearchPlaceholderComponent extends StatelessWidget {
  final VoidCallback onTap;

  const StockSearchPlaceholderComponent({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: SearchBar(hintText: S.of(context).stock_searchHint, leading: const Icon(Icons.search)),
      ),
    );
  }
}
