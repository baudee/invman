import 'package:flutter/material.dart';

class ToastUtils {
  static void message(BuildContext context, String? text, {bool success = true}) {
    if (text == null) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: success ? null : Colors.red,
      ),
    );
  }
}
