import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferListComponent extends HookWidget {
  final int investmentId;

  const TransferListComponent({super.key, required this.investmentId});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<TransferListController>(param1: investmentId));
    return BaseStateComponent(
      state: controller,
      successBuilder: (_) => InfiniteListComponent(
        controller: controller,
        itemBuilder: (transfer) => TransferTileComponent(transfer: transfer),
      ),
    );
  }
}
