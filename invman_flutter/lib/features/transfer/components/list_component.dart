import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferListComponent extends ConsumerWidget {
  const TransferListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(transferListProvider.notifier);
    final pagingController = provider.pagingController;

    return InfiniteListComponent<Transfer>(
      pagingController: pagingController,
      itemBuilder: (context, transfer, index) {
        return TransferTileComponent(transfer: transfer);
      },
    );
  }
}
