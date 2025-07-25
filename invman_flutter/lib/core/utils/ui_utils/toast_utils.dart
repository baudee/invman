import 'package:flutter/material.dart';
import 'package:invman_flutter/core/navigation/router/app_router.dart';

class ToastUtils {
  static void message(String? text, {bool success = true}) {
    if (text == null) {
      return;
    }
    final context = rootNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: success ? null : Colors.red,
        ),
      );
    }
  }
}
