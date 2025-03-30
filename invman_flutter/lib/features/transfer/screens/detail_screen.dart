import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferDetailScreen extends StatelessWidget {
  final int id;
  const TransferDetailScreen({super.key, required this.id});
  static String route([int? id]) => "${TransferRoutes.namespace}/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(TransferEditScreen.route(id)),
          ),
        ],
      ),
      body: TransferDetailComponent(id: id),
    );
  }
}
