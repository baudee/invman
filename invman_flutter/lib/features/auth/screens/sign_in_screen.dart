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
    final theme = Theme.of(context);

    return BaseScreen(
      noPadding: true,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [theme.colorScheme.primaryContainer, theme.scaffoldBackgroundColor],
                ),
              ),
            ),
          ),
          SignInWidget(
            client: getIt<Client>(),
            onError: (error) => ToastUtils.message(error.toString(), success: false),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
