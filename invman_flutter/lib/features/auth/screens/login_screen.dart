import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class LoginScreen extends BaseScreen {
  const LoginScreen({super.key});

  static String route() => "/login";

  @override
  AppBar? appBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(S.of(context).auth_logIn),
    );
  }

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return Center(child: LoginComponent());
  }
}
