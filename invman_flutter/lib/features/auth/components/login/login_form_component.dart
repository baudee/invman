import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class LoginFormComponent extends ConsumerStatefulWidget {
  final String? email;
  final String? password;
  const LoginFormComponent({super.key, this.email, this.password});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends ConsumerState<LoginFormComponent> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? "";
    passwordController.text = widget.password ?? "";
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                      final errorMessage = await provider.initiatePasswordReset(email);
                      if (errorMessage != null) {
                        ToastUtils.message(errorMessage, success: false);
                      }
                    }
                  },
                  child: Text(S.of(context).auth_forgotPassword)),
              ElevatedButton(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  final errorMessage = await provider.loginWithEmail(
                    email: emailController.text.trim(),
                    password: passwordController.text,
                  );

                  ToastUtils.message(errorMessage, success: false);
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
                  provider.setCredentialsInState(emailController.text.trim(), passwordController.text);
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
