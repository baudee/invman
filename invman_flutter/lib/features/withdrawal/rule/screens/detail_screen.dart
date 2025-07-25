import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/withdrawal/withdrawal.dart';

class WithdrawalRuleDetailScreen extends BaseScreen<WithdrawalRule> {
  final int id;
  const WithdrawalRuleDetailScreen({super.key, required this.id});
  static String route([int? id]) => "/${id ?? ':id'}";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalRuleDetailProvider(id));
    return AppBar(
      title: state is Success<WithdrawalRule> ? Text(state.data.name) : null,
      actions: [
        EditIconButton(
          onPressed: () => router.pushRelative(WithdrawalRuleEditScreen.route()),
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalRuleDetailProvider(id));
    return BaseStateComponent(
      state: state,
      successBuilder: (rule) => WithdrawalRuleDetailComponent(rule: rule),
      onErrorRefresh: () => ref.read(withdrawalRuleDetailProvider(id).notifier).load(),
    );
  }

  @override
  FloatingActionButton? floatingActionButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        router.pushRelative(WithdrawalFeeEditScreen.route(0));
      },
      child: Icon(Icons.add),
    );
  }
}
