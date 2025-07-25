import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeTileComponent extends ConsumerWidget {
  final WithdrawalFee fee;

  const WithdrawalFeeTileComponent({super.key, required this.fee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    final theme = Theme.of(context);
    
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(
          Icons.percent,
          color: theme.colorScheme.primary,
          size: UIConstants.iconMd,
        ),
      ),
      title: Text("${fee.percent}%"),
      subtitle: Text("${S.of(context).withdrawal_fixed}: ${fee.fixed.toStringPrice(currency)} - ${S.of(context).withdrawal_minimum}: ${fee.minimum.toStringPrice(currency)}"),
      onTap: () => router.pushRelative(WithdrawalFeeDetailScreen.route(fee.id)),
    );
  }
}
