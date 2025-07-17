import 'package:flutter/material.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class InvestmentDetailScreen extends StatelessWidget {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => router.pushRelative(InvestmentEditScreen.route()),
          ),
        ],
      ),
      body: InvestmentDetailComponent(id: id),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          router.pushRelative(TransferEditScreen.route(0));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
