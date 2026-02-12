import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';

class TransferEditScreen extends StatefulWidget {
  final int id;
  final int investmentId;
  const TransferEditScreen({super.key, required this.id, required this.investmentId});

  static String route([int? id]) => id == null ? "/:transferId/edit" : "/$id/edit";

  @override
  State<TransferEditScreen> createState() => _TransferEditScreenState();
}

class _TransferEditScreenState extends State<TransferEditScreen> {
  late final TransferFormController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<TransferFormController>(param1: widget.investmentId, param2: widget.id);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == 0 ? S.of(context).transfer_create : S.of(context).transfer_edit),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.appHorizontalPadding),
          child: BaseStateComponent<Transfer>(
            state: controller.state,
            successBuilder: (transfer) => TransferFormComponent(controller: controller),
          ),
        ),
      ),
    );
  }
}
