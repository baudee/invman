import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalFeeDetailScreen extends BaseScreen {
  final int id;
  const WithdrawalFeeDetailScreen({super.key, required this.id});
  static String route([int? id]) => "${WithdrawalRoutes.namespaceFee}/${id ?? ':idFee'}";

  @override
  AppBar? appBar(BuildContext context) {
    return AppBar(
      actions: [EditIconButton(onPressed: () => getIt<GoRouter>().pushRelative(WithdrawalFeeEditScreen.route()))],
    );
  }

  @override
  Widget body(BuildContext context) {
    return BaseStateComponent<WithdrawalFee>(
      state: getIt<WithdrawalFeeDetailController>(param1: id),
      successBuilder: (fee) => WithdrawalFeeDetailComponent(fee: fee),
    );
  }
}
