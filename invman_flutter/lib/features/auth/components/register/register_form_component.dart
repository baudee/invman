import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class RegisterFormComponent extends ConsumerStatefulWidget {
  final String? email;
  final String? password;
  const RegisterFormComponent({super.key, this.email, this.password});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormComponentState();
}

class _RegisterFormComponentState extends ConsumerState<RegisterFormComponent> {
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
            validator: ValidationUtils.formValidatorPassword,
            decoration: InputDecoration(
              label: Text(S.of(context).auth_password),
            ),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              final email = emailController.text.trim();
              final password = passwordController.text;

              final errorMessage = await provider.registerWithEmail(
                email: email,
                password: password,
              );

              if (errorMessage != null) {
                ToastUtils.message(errorMessage, success: false);
              }
            },
            child: Text(S.of(context).auth_signUp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).auth_alreadyHaveAnAccount),
              TextButton(
                onPressed: () {
                  provider.setCredentialsInState(emailController.text.trim(), passwordController.text);
                  context.go(LoginScreen.route());
                },
                child: Text(S.of(context).auth_logIn),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
