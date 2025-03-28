import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class LoginFormComponent extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;
  const LoginFormComponent({super.key, this.onSuccess});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends ConsumerState<LoginFormComponent> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // password reset
  final passwordResetFormKey = GlobalKey<FormState>();
  final passwordResetCodeController = TextEditingController();
  final passwordResetNewPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordResetCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    if (authState is AuthStatePasswordResetCodeRequired) {
      if (authState.isLoading) {
        return LoadingComponent();
      } else {
        return Form(
          key: passwordResetFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).auth_checkEmailCode),
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    authState.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextFormField(
                controller: passwordResetCodeController,
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).auth_verificationCode),
                decoration: InputDecoration(
                  label: Text(S.of(context).auth_verificationCode),
                ),
                autofocus: true,
              ),
              TextFormField(
                controller: passwordResetNewPasswordController,
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).auth_newPassword),
                decoration: InputDecoration(
                  label: Text(S.of(context).auth_newPassword),
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!passwordResetFormKey.currentState!.validate()) {
                    return;
                  }

                  ref.read(authProvider.notifier).completePasswordReset(
                        passwordResetCodeController.text,
                        passwordResetNewPasswordController.text,
                        authState.email,
                      );
                },
                child: Text(S.of(context).core_submit),
              )
            ],
          ),
        );
      }
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (authState is AuthStateGuest && authState.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                authState.error!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          TextFormField(
            controller: emailController,
            validator: ValidationUtils.formValidatorEmail,
            decoration: InputDecoration(
              label: Text(S.of(context).auth_email),
            ),
            autofocus: true,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).auth_password),
            decoration: InputDecoration(
              label: Text(S.of(context).auth_password),
            ),
            obscureText: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () async {
                    final email = await PromptDialog.show(
                      context: context,
                      title: S.of(context).auth_email,
                      labelText: S.of(context).auth_yourEmail,
                      initialValue: emailController.text,
                      confirmText: S.of(context).auth_resetPassword,
                      validator: ValidationUtils.formValidatorEmail,
                    );

                    if (email != null && email.isNotEmpty) {
                      await ref.read(authProvider.notifier).initiatePasswordReset(email);
                    }
                  },
                  child: Text(S.of(context).auth_forgotPassword)),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  ref.read(authProvider.notifier).loginWithEmail(
                        email: emailController.text.trim(),
                        password: passwordController.text,
                      );
                },
                child: Text(S.of(context).auth_logIn),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).auth_dontHaveAnAccount),
              TextButton(
                onPressed: () {
                  context.go(RegisterScreen.route());
                },
                child: Text(S.of(context).auth_signUp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
