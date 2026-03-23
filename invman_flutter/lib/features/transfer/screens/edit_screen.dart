import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferEditScreen extends HookWidget {
  final int id;
  final int investmentId;
  const TransferEditScreen({super.key, required this.id, required this.investmentId});

  static const pathSegment = ':transferId/edit';
  static String route(int investmentId, int transferId) =>
      '${InvestmentRootScreen.pathSegment}/$investmentId/${TransferRootScreen.pathSegment}/$transferId/edit';

  @override
  Widget build(BuildContext context) {
    final controller = useController(() => getIt<TransferEditController>(param1: investmentId, param2: id));
    return BaseScreen(
      appBar: AppBar(title: Text(id == 0 ? S.of(context).transfer_create : S.of(context).transfer_edit)),
      body: BaseStateComponent(
        state: controller.state,
        onReload: controller.reload,
        successBuilder: (_) => TransferFormComponent(controller: controller),
      ),
    );
  }
}
