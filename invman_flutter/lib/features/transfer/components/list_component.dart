import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferListComponent extends BaseComponent {
  final int investmentId;

  const TransferListComponent({super.key, required this.investmentId});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final provider = ref.read(transferListProvider(investmentId).notifier);
    final pagingController = provider.pagingController;
    return InfiniteListComponent<Transfer>(
      onRefresh: provider.refresh,
      pagingController: pagingController,
      itemBuilder: (context, transfer, index) {
        return TransferTileComponent(transfer: transfer);
      },
    );
  }
}
