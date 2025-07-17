import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class InvestmentDetailScreen extends BaseScreen<Investment> {
  final int id;
  const InvestmentDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    final state = ref.watch(investmentDetailProvider(id));
    return AppBar(
      title: state is Success<Investment> ? Text(state.data.name) : null,
      actions: [
        EditIconButton(
          onPressed: () => router.pushRelative(InvestmentEditScreen.route()),
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(investmentDetailProvider(id));
    return BaseStateComponent(
      state: state,
      successBuilder: (investment) => InvestmentDetailComponent(investment: investment),
      onErrorRefresh: () => ref.read(investmentDetailProvider(id).notifier).load(),
    );
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        router.pushRelative(TransferEditScreen.route(0));
      },
      child: Icon(Icons.add),
    );
  }
}
