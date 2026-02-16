import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferRootScreen extends HookWidget {
  final int investmentId;
  const TransferRootScreen({super.key, required this.investmentId});

  static String route() => InvestmentRoutes.namespaceTransfer;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).transfer_title)),
      body: InfiniteListComponent(
        controller: useMemoized(
          () => getIt<TransferListController>(param1: investmentId),
        ),
        itemBuilder: (transfer) => TransferTileComponent(transfer: transfer),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.pushRelative(TransferEditScreen.route(0)),
        child: Icon(Icons.add),
      ),
    );
  }
}
