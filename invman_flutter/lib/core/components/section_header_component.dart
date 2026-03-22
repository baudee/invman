import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';

class SectionHeaderComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeaderComponent({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        if (onSeeAll != null) TextButton(onPressed: onSeeAll, child: Text(S.of(context).core_seeAll)),
      ],
    );
  }
}
