import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferDetailScreen extends BaseScreen<Transfer> {
  final int id;
  const TransferDetailScreen({super.key, required this.id});
  static const String idKey = 'transferId';
  static String route([int? id]) => "${InvestmentRoutes.namespaceTransfer}/${id ?? ':$idKey'}";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferDetailProvider(id));
    return AppBar(
      title: state is Success<Transfer> ? Text('${state.data.quantity} ${state.data.amount}') : null,
      actions: [
        EditIconButton(
          onPressed: () => router.pushRelative(TransferEditScreen.route()),
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferDetailProvider(id));
    return BaseStateComponent(
      state: state,
      successBuilder: (transfer) => TransferDetailComponent(transfer: transfer),
      onErrorRefresh: () => ref.read(transferDetailProvider(id).notifier).load(),
    );
  }
}
