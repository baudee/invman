import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/router.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferRootScreen extends StatelessWidget {
  final int investmentId;
  const TransferRootScreen({super.key, required this.investmentId});

  static String route() => InvestmentRoutes.namespaceTransfer;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appBar: AppBar(title: Text(S.of(context).transfer_title)),
      body: TransferListComponent(investmentId: investmentId),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.pushRelative(TransferEditScreen.route(0)),
        child: Icon(Icons.add),
      ),
    );
  }
}
