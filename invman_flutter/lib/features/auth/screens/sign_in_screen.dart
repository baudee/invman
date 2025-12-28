import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInScreen extends BaseScreen {
  const SignInScreen({super.key});

  static String route() => "/signin";

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    return SignInWidget(
      client: ref.read(clientProvider),
      onError: (error) => ToastUtils.message(error.toString(), success: false),
    );
  }
}
