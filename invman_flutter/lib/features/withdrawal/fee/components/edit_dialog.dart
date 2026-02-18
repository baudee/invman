import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class WithdrawalFeeEditDialog extends StatefulWidget {
  final WithdrawalFee? initialFee;
  final int ruleId;

  const WithdrawalFeeEditDialog({
    super.key,
    this.initialFee,
    required this.ruleId,
  });

  static Future<WithdrawalFee?> show({
    required BuildContext context,
    WithdrawalFee? initialFee,
    required int ruleId,
  }) {
    return showDialog<WithdrawalFee>(
      context: context,
      builder: (context) =>
          WithdrawalFeeEditDialog(initialFee: initialFee, ruleId: ruleId),
    );
  }

  @override
  State<WithdrawalFeeEditDialog> createState() =>
      _WithdrawalFeeEditDialogState();
}

class _WithdrawalFeeEditDialogState extends State<WithdrawalFeeEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _percentController;
  late final TextEditingController _fixedController;
  late final TextEditingController _minimumController;

  bool get _isEditing => widget.initialFee != null;

  @override
  void initState() {
    super.initState();
    final fee = widget.initialFee;
    _percentController = TextEditingController(
      text: fee?.percent.toString() ?? '0.0',
    );
    _fixedController = TextEditingController(
      text: fee?.fixed.toStringAsFixed(2) ?? '0.00',
    );
    _minimumController = TextEditingController(
      text: fee?.minimum.toStringAsFixed(2) ?? '0.00',
    );
  }

  @override
  void dispose() {
    _percentController.dispose();
    _fixedController.dispose();
    _minimumController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (!_formKey.currentState!.validate()) return;

    final percent = double.parse(_percentController.text.trim());
    final fixed = double.parse(_fixedController.text.trim());
    final minimum = double.parse(_minimumController.text.trim());

    final fee =
        widget.initialFee?.copyWith(
          percent: percent,
          fixed: fixed,
          minimum: minimum,
        ) ??
        WithdrawalFee(
          ruleId: widget.ruleId,
          percent: percent,
          fixed: fixed,
          minimum: minimum,
        );

    Navigator.of(context).pop(fee);
  }

  void _onCancel() {
    Navigator.of(context).pop(null);
  }

  @override
  Widget build(BuildContext context) {
    final authManager = getIt<AuthManager>();
    final l10n = S.of(context);

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      title: Text(
        _isEditing ? l10n.withdrawal_fee_edit : l10n.withdrawal_fee_create,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _percentController,
              validator: ValidationUtils.formValidatorDouble,
              decoration: InputDecoration(
                label: Text(l10n.withdrawal_percentage),
                suffixText: '%',
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _fixedController,
              validator: ValidationUtils.formValidatorDouble,
              decoration: InputDecoration(
                label: Text(l10n.withdrawal_fixed),
                suffixText: authManager.currencyCode,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _minimumController,
              validator: ValidationUtils.formValidatorDouble,
              decoration: InputDecoration(
                label: Text(l10n.withdrawal_minimum),
                suffixText: authManager.currencyCode,
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: _onCancel, child: Text(l10n.core_cancel)),
        TextButton(onPressed: _onConfirm, child: Text(l10n.core_save)),
      ],
    );
  }
}
