import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/account/account.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalEditScreen extends StatelessWidget {
  final int id;
  const WithdrawalEditScreen({super.key, required this.id});

  static String route([int? id]) => "${WithdrawalRoutes.namespace}/${id ?? ':id'}/edit";
  static String absoluteRoute([int? id]) =>
      "${AccountRoutes.namespace}${WithdrawalRoutes.namespace}/${id ?? ':id'}/edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? S.of(context).withdrawal_create : S.of(context).withdrawal_edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.appPadding),
        child: WithdrawalFormComponent(id: id),
      ),
    );
  }
}
