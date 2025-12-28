import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferRootScreen extends BaseScreen {
  final int investmentId;
  const TransferRootScreen({super.key, required this.investmentId});

  static String route() => InvestmentRoutes.namespaceTransfer;

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(title: Text(S.of(context).transfer_title));
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return TransferListComponent(investmentId: investmentId);
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        router.pushRelative(TransferEditScreen.route(0));
      },
      child: Icon(Icons.add),
    );
  }
}
