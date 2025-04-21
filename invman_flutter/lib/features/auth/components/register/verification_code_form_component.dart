import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/providers/providers.dart';

class VerificationCodeFormComponent extends ConsumerStatefulWidget {
  final String email;
  final String password;
  const VerificationCodeFormComponent({super.key, required this.email, required this.password});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerificationCodeFormComponentState();
}

class _VerificationCodeFormComponentState extends ConsumerState<VerificationCodeFormComponent> {
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              final errorMessage = await ref.read(authProvider.notifier).confirmEmailRegister(
                    email: widget.email,
                    password: widget.password,
                    verificationCode: codeController.text,
                  );

              if (errorMessage != null && context.mounted) {
                ToastUtils.message(context, errorMessage, success: false);
              }
            },
            child: Text(S.of(context).core_submit),
          )
        ],
      ),
    );
  }
}
