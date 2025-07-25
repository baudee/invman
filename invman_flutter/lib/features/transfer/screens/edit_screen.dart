import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferEditScreen extends BaseScreen {
  final int id;
  final int investmentId;
  const TransferEditScreen({super.key, required this.id, required this.investmentId});

  static String route([int? id]) => id == null ? "/edit" : "${InvestmentRoutes.namespaceTransfer}/$id/edit";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(id == 0 ? S.of(context).transfer_create : S.of(context).transfer_edit),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transferFormProvider(investmentId, id));
    return BaseStateComponent(
      state: state,
      successBuilder: (transfer) => TransferFormComponent(id: id, investmentId: investmentId),
      onErrorRefresh: () => ref.read(transferFormProvider(investmentId, id).notifier).load(),
    );
  }
}
