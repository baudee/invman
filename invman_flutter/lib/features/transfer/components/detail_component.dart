import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';

class TransferDetailComponent extends ConsumerWidget {
  final Transfer transfer;
  const TransferDetailComponent({super.key, required this.transfer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(transfer.amount.toStringPrice(ref.read(userPreferencesProvider).currency)),
        Divider(),
        Text(transfer.quantity.toString()),
      ],
    );
  }
}
