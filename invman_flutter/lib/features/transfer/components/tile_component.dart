import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferTileComponent extends ConsumerWidget {
  final Transfer transfer;

  const TransferTileComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    final isPositive = transfer.amount > 0;
    
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isPositive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
        child: Icon(
          isPositive ? Icons.add : Icons.remove,
          color: isPositive ? Colors.green : Colors.red,
          size: UIConstants.iconMd,
        ),
      ),
      title: Text(transfer.amount.toStringPrice(currency)),
      subtitle: Text('${S.of(context).investment_quantity}: ${transfer.quantity}'),
      onTap: () => router.pushRelative(TransferDetailScreen.route(transfer.id)),
    );
  }
}
