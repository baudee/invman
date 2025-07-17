import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferTileComponent extends ConsumerWidget {
  final Transfer transfer;

  const TransferTileComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.read(userPreferencesProvider).currency;
    return ListTile(
      title: Text(transfer.amount.toStringPrice(currency)),
      trailing: Text(transfer.quantity.toString(), overflow: TextOverflow.ellipsis),
      onTap: () => router.pushRelative(TransferDetailScreen.route(transfer.id)),
    );
  }
}
