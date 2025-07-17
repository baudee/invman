import 'package:flutter/material.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static String route() => "/register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).auth_signUp),
      ),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.appVerticalPadding),
        child: Center(child: RegisterComponent()),
      ),
    );
  }
}
