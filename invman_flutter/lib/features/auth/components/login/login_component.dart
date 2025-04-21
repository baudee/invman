import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class LoginComponent extends ConsumerWidget {
  const LoginComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    return switch (state) {
      AuthStateBooting() || AuthStateLoading() => const LoadingComponent(),
      AuthStateGuest(:final email, :final password) => LoginFormComponent(
          email: email,
          password: password,
        ),
      AuthStatePasswordResetCodeRequired(:final email) => PasswordResetFormComponent(email: email),
      AuthStateVerificationCodeRequired() => ErrorComponent(error: S.of(context).error_invalidState),
      AuthStateSuccess() => const LoggedInComponent(),
    };
  }
}
