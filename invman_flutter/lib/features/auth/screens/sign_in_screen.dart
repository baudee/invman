import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/di.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static String route() => "/signin";

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: SignInWidget(
        client: getIt<Client>(),
        onError: (error) => ToastUtils.message(error.toString(), success: false),
      ),
    );
  }
}
