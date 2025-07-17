import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeDetailScreen extends BaseScreen<WithdrawalFee> {
  final int id;
  const WithdrawalFeeDetailScreen({super.key, required this.id});
  static String route([int? id]) => "${WithdrawalRoutes.namespaceFee}/${id ?? ':idFee'}";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      actions: [
        EditIconButton(
          onPressed: () => router.pushRelative(WithdrawalFeeEditScreen.route()),
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalFeeDetailProvider(id));
    return BaseStateComponent(
      state: state,
      successBuilder: (fee) => WithdrawalFeeDetailComponent(fee: fee),
      onErrorRefresh: () => ref.read(withdrawalFeeDetailProvider(id).notifier).load(),
    );
  }
}
