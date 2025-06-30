import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleEditScreen extends StatelessWidget {
  final int id;
  const WithdrawalRuleEditScreen({super.key, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "/$id/edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == 0 ? S.of(context).withdrawal_create : S.of(context).withdrawal_edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.appPadding),
        child: WithdrawalRuleFormComponent(id: id),
      ),
    );
  }
}
