import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData themeData;

  const AppTheme(this.themeData);

  factory AppTheme.light() {
    final themeData = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
    );

    return AppTheme(themeData);
  }
  factory AppTheme.dark() {
    final themeData = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    return AppTheme(themeData);
  }
}
