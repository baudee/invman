import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalDetailScreen extends StatelessWidget {
  final int id;
  const WithdrawalDetailScreen({super.key, required this.id});
  static String route([int? id]) => "${WithdrawalRoutes.namespace}/${id ?? ':id'}";
  static String absoluteRoute([int? id]) => "${AccountRoutes.namespace}${WithdrawalRoutes.namespace}/${id ?? ':id'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(WithdrawalEditScreen.absoluteRoute(id)),
          ),
        ],
      ),
      body: WithdrawalDetailComponent(id: id),
    );
  }
}
