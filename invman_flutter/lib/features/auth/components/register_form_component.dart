import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
              Text("Check your email for a verification code!"),
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
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, "Verification Code"),
                decoration: InputDecoration(
                  label: Text("Verification Code"),
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
                child: Text("Submit"),
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
              label: Text("Email Address"),
            ),
            autofocus: true,
          ),
          TextFormField(
            controller: passwordController,
            validator: ValidationUtils.formValidatorPassword,
            decoration: InputDecoration(
              label: Text("Password"),
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
            child: Text("Register"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? "),
              TextButton(
                onPressed: () {
                  context.go(LoginScreen.route());
                },
                child: Text("Login"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
