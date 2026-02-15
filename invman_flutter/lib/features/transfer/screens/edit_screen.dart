import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferEditScreen extends HookWidget {
  final int id;
  final int investmentId;
  const TransferEditScreen({super.key, required this.id, required this.investmentId});

  static String route([int? id]) => id == null ? "/:transferId/edit" : "/$id/edit";

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(() => getIt<TransferEditController>(param1: investmentId, param2: id));
    return BaseScreen(
      appBar: AppBar(title: Text(id == 0 ? S.of(context).transfer_create : S.of(context).transfer_edit)),
      body: BaseStateComponent(
        state: controller,
        successBuilder: (_) => TransferFormComponent(controller: controller),
      ),
    );
  }
}
