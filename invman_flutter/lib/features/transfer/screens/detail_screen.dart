import 'package:flutter/material.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferDetailScreen extends StatelessWidget {
  final int id;
  const TransferDetailScreen({super.key, required this.id});
  static const String idKey = 'transferId';
  static String route([int? id]) => "${InvestmentRoutes.namespaceTransfer}/${id ?? ':$idKey'}";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => router.pushRelative(TransferEditScreen.route()),
          ),
        ],
      ),
      body: TransferDetailComponent(id: id),
    );
  }
}
