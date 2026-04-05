import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/navigation/navigation.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/di.dart';
import 'package:invman_flutter/features/auth/auth.dart';
import 'package:invman_flutter/features/transfer/transfer.dart';
import 'package:signals_flutter/signals_flutter.dart';

class TransferFormComponent extends StatelessWidget {
  final TransferEditController controller;
  const TransferFormComponent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final transferId = controller.state.value.requireValue.id;
    final authManager = getIt<AuthManager>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    SegmentedButton<bool>(
                      segments: [
                        ButtonSegment(value: false, label: Text(S.of(context).transfer_buy)),
                        ButtonSegment(value: true, label: Text(S.of(context).transfer_sell)),
                      ],
                      selected: {controller.isSell.watch(context)},
                      onSelectionChanged: (selection) => controller.setIsSell(selection.first),
                    ),
                    const SizedBox(height: UIConstants.spacingSm),
                    TextFormField(
                      controller: controller.amountController,
                      validator: (value) => ValidationUtils.formValidatorDouble(value),
                      decoration: InputDecoration(
                        label: Text(S.of(context).transfer_amount),
                        suffixText: authManager.currencyCode,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: controller.quantityController,
                      validator: (value) => ValidationUtils.formValidatorDouble(value),
                      decoration: InputDecoration(
                        label: Text(S.of(context).transfer_quantity),
                        suffixText: authManager.currencyCode,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: UIConstants.spacingSm),
                    SectionHeaderComponent(title: S.of(context).transfer_date),
                    CalendarDatePicker(
                      initialDate: controller.state.watch(context).requireValue.createdAt,
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                      onDateChanged: (date) => controller.setTransferDate(date),
                    ),
                    const Spacer(),
                    SaveButton(
                      onPressed: () async {
                        final (success, message) = await controller.submit();
                        ToastUtils.message(message, success: success);
                        if (success) {
                          router.pop();
                        }
                      },
                    ),
                    SizedBox(height: UIConstants.spacingSm),
                    if (transferId != null && transferId != 0) ...[
                      DeleteButton(
                        onPressed: () async {
                          final (success, message) = await controller.delete();
                          ToastUtils.message(message, success: success);
                          if (success) {
                            router.pop();
                          }
                        },
                      ),
                      SizedBox(height: UIConstants.spacingMd),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
