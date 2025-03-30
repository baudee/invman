import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferTileComponent extends ConsumerWidget {
  final Transfer transfer;

  const TransferTileComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    return ListTile(
      title: Text(transfer.stock?.name ?? S.of(context).core_noName, overflow: TextOverflow.ellipsis),
      subtitle: Text(transfer.quantity.toString()),
      trailing: Text(transfer.amount.toStringPrice(currency)),
      onTap: () => context.push(TransferDetailScreen.route(transfer.id)),
    );
  }
}
