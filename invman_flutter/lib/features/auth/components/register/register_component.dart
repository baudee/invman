import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/components/components.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class RegisterComponent extends ConsumerWidget {
  const RegisterComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    return switch (state) {
      AuthStateBooting() || AuthStateLoading() => const LoadingComponent(),
      AuthStateGuest(:final email, :final password) => RegisterFormComponent(
          email: email,
          password: password,
        ),
      AuthStatePasswordResetCodeRequired() => ErrorComponent(error: S.of(context).error_invalidState),
      AuthStateVerificationCodeRequired(:final email, :final password) => VerificationCodeFormComponent(
          email: email,
          password: password,
        ),
      AuthStateSuccess() => const LoggedInComponent(),
    };
  }
}
