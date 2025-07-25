import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleEditScreen extends BaseScreen {
  final int id;
  const WithdrawalRuleEditScreen({super.key, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "/$id/edit";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(id == 0 ? S.of(context).withdrawal_create : S.of(context).withdrawal_edit),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalRuleFormProvider(id));
    return BaseStateComponent(
      state: state,
      successBuilder: (rule) => WithdrawalRuleFormComponent(id: id),
      onErrorRefresh: () => ref.read(withdrawalRuleFormProvider(id).notifier).load(),
    );
  }
}
