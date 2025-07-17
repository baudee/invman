import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeEditScreen extends BaseScreen {
  final int ruleId;
  final int id;
  const WithdrawalFeeEditScreen({super.key, required this.ruleId, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "${WithdrawalRoutes.namespaceFee}/$id/edit";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(id == 0 ? S.of(context).withdrawal_fee_create : S.of(context).withdrawal_fee_edit),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalFeeFormProvider(ruleId, id));
    return BaseStateComponent(
      state: state,
      successBuilder: (fee) => WithdrawalFeeFormComponent(ruleId: ruleId, id: id),
      onErrorRefresh: () => ref.read(withdrawalFeeFormProvider(ruleId, id).notifier).load(),
    );
  }
}
