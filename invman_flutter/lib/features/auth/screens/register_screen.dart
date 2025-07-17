import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class RegisterScreen extends BaseScreen {
  const RegisterScreen({super.key});

  static String route() => "/register";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(S.of(context).auth_signUp),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return Center(child: RegisterComponent());
  }
}
