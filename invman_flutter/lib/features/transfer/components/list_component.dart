import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferListComponent extends StatefulWidget {
  final int investmentId;

  const TransferListComponent({super.key, required this.investmentId});

  @override
  State<TransferListComponent> createState() => _TransferListComponentState();
}

class _TransferListComponentState extends State<TransferListComponent> {
  late final TransferListController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<TransferListController>(param1: widget.investmentId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteListComponent<Transfer>(
      onRefresh: controller.refresh,
      pagingController: controller.pagingController,
      itemBuilder: (context, transfer, index) {
        return TransferTileComponent(transfer: transfer);
      },
    );
  }
}
