import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferEditScreen extends StatelessWidget {
  final int id;
  final int investmentId;
  const TransferEditScreen({super.key, required this.id, required this.investmentId});

  static String route([int? id]) => id == null ? "/edit" : "${InvestmentRoutes.namespaceTransfer}/$id/edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? S.of(context).transfer_create : S.of(context).transfer_edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.appVerticalPadding),
        child: TransferFormComponent(id: id, investmentId: investmentId),
      ),
    );
  }
}
