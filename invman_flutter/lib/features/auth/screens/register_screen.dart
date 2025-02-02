import 'package:flutter/material.dart';
import 'package:invman_flutter/features/auth/auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static String route() => "/register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: RegisterFormComponent()),
      ),
    );
  }
}
