import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
              Text("Check your email for a verification code!"),
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
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, "Verification Code"),
                decoration: InputDecoration(
                  label: Text("Verification Code"),
                ),
                autofocus: true,
              ),
              TextFormField(
                controller: passwordResetNewPasswordController,
                validator: (value) => ValidationUtils.formValidatorNotEmpty(value, "New Password"),
                decoration: InputDecoration(
                  label: Text("New Password"),
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
              label: Text("Email Address"),
            ),
            autofocus: true,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) => ValidationUtils.formValidatorNotEmpty(value, "Password"),
            decoration: InputDecoration(
              label: Text("Password"),
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
                      title: "Email",
                      labelText: "Your Email Address",
                      initialValue: emailController.text,
                      confirmText: "Reset Password",
                      validator: ValidationUtils.formValidatorEmail,
                    );

                    if (email != null && email.isNotEmpty) {
                      await ref.read(authProvider.notifier).initiatePasswordReset(email);
                    }
                  },
                  child: Text("Forgot Password?")),
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
                child: Text("Login"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  context.go(RegisterScreen.route());
                },
                child: Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
