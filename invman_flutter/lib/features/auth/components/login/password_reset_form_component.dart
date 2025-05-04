import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/providers/providers.dart';

class PasswordResetFormComponent extends ConsumerStatefulWidget {
  final String email;
  const PasswordResetFormComponent({super.key, required this.email});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PasswordResetFormComponentState();
}

class _PasswordResetFormComponentState extends ConsumerState<PasswordResetFormComponent> {
  final formKey = GlobalKey<FormState>();

  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(authProvider.notifier);
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).auth_checkEmailCode),
          TextFormField(
            controller: codeController,
            validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).auth_verificationCode),
            decoration: InputDecoration(
              label: Text(S.of(context).auth_verificationCode),
            ),
            autofocus: true,
          ),
          TextFormField(
            controller: newPasswordController,
            validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).auth_newPassword),
            decoration: InputDecoration(
              label: Text(S.of(context).auth_newPassword),
            ),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              final errorMessage = await provider.completePasswordReset(
                codeController.text,
                newPasswordController.text,
                widget.email,
              );
              if (errorMessage != null) {
                ToastUtils.message(errorMessage, success: false);
              }
            },
            child: Text(S.of(context).core_submit),
          ),
          FilledButton(
            onPressed: () => provider.resetState(),
            child: Text(S.of(context).core_cancel),
          )
        ],
      ),
    );
  }
}
