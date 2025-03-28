import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class RegisterFormComponent extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;
  const RegisterFormComponent({super.key, this.onSuccess});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormComponentState();
}

class _RegisterFormComponentState extends ConsumerState<RegisterFormComponent> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final verificationFormKey = GlobalKey<FormState>();
  final verificationCodeController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      ref.read(authProvider.notifier).clearError();
    });
    passwordController.addListener(() {
      ref.read(authProvider.notifier).clearError();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    if (authState is AuthStateVerificationCodeRequired) {
      if (authState.isLoading) {
        return LoadingComponent();
      } else {
        return Form(
          key: verificationFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(S.of(context).auth_checkEmailCode),
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    authState.error!,
                    style: TextStyle(color: Colors.red.shade700),
                    textAlign: TextAlign.center,
                  ),
                ),
              TextFormField(
                controller: verificationCodeController,
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, S.of(context).auth_verificationCode),
                decoration: InputDecoration(
                  label: Text(S.of(context).auth_verificationCode),
                ),
                autofocus: true,
              ),
              ElevatedButton(
                onPressed: () {
                  if (!verificationFormKey.currentState!.validate()) {
                    return;
                  }

                  ref.read(authProvider.notifier).confirmEmailRegister(
                        email: authState.email,
                        password: authState.password,
                        verificationCode: verificationCodeController.text,
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
          if (authState is AuthStateGuest && authState.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                authState.error!,
                style: TextStyle(color: Colors.red.shade700),
                textAlign: TextAlign.center,
              ),
            ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }

              final email = emailController.text.trim();
              final password = passwordController.text;

              ref.read(authProvider.notifier).registerWithEmail(
                    email: email,
                    password: password,
                  );
            },
            child: Text(S.of(context).auth_signUp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).auth_alreadyHaveAnAccount),
              TextButton(
                onPressed: () {
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
