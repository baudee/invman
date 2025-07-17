import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentEditScreen extends BaseScreen {
  final int id;
  const InvestmentEditScreen({super.key, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "/$id/edit";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(id == 0 ? S.of(context).investment_create : S.of(context).investment_edit),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(investmentFormProvider(id));
    return BaseStateComponent(
      state: state,
      successBuilder: (investment) => InvestmentFormComponent(id: id),
      onErrorRefresh: () => ref.read(investmentFormProvider(id).notifier).load(),
    );
  }
}
