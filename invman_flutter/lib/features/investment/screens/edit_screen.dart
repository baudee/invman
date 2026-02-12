import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/investment/investment.dart';

class InvestmentEditScreen extends StatefulWidget {
  final int id;
  const InvestmentEditScreen({super.key, required this.id});

  static String route([int? id]) => id == null ? "/edit" : "/$id/edit";

  @override
  State<InvestmentEditScreen> createState() => _InvestmentEditScreenState();
}

class _InvestmentEditScreenState extends State<InvestmentEditScreen> {
  late final InvestmentFormController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<InvestmentFormController>(param1: widget.id);
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
        title: Text(widget.id == 0 ? S.of(context).investment_create : S.of(context).investment_edit),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: UIConstants.appHorizontalPadding),
          child: BaseStateComponent<Investment>(
            state: controller.state,
            successBuilder: (investment) => InvestmentFormComponent(controller: controller),
          ),
        ),
      ),
    );
  }
}
