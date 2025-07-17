import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  static final searchBarTheme = SearchBarThemeData(elevation: WidgetStateProperty.all(0.0));

  factory AppTheme.light() {
    final themeData = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      searchBarTheme: searchBarTheme,
    );

    return AppTheme(themeData);
  }
  factory AppTheme.dark() {
    final themeData = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      searchBarTheme: searchBarTheme,
    );

    return AppTheme(themeData);
  }
}
