import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/utils/utils.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String route() => "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).auth_logIn),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.appVerticalPadding),
        child: Center(child: LoginComponent()),
      ),
    );
  }
}
