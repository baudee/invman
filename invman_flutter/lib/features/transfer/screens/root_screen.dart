import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferRootScreen extends StatelessWidget {
  const TransferRootScreen({super.key});

  static String route() => TransferRoutes.namespace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).transfer_title),
      ),
      body: TransferListComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(TransferEditScreen.route(0));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
