import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

class DividendListTile extends StatelessWidget {
  final ComputedDividendValue entry;

  const DividendListTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final investment = entry.investment;
    return Material(
      child: ListTile(
        leading: investment.asset != null ? AvatarComponent(asset: investment.asset!) : null,
        title: Text(investment.name),
        subtitle: Text(DateFormat.yMMMd(Localizations.localeOf(context).toString()).format(entry.date)),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              entry.amount.toStringPrice(investment.asset?.currency?.code),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "${entry.amountPerShare.toStringPrice(investment.asset?.currency?.code)} / ${S.of(context).core_share}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
