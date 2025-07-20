import 'package:flutter/material.dart';
import 'package:invman_flutter/core/core.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  static final _searchBarTheme = SearchBarThemeData(elevation: WidgetStateProperty.all(0.0));

  static const _seedColor = Colors.deepPurple;

  static ListTileThemeData _listTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingLg, vertical: UIConstants.spacingXs),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.radiusMd),
      ),
      tileColor: colorScheme.surfaceContainerLow,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      subtitleTextStyle: TextStyle(
        color: colorScheme.onSurface.withValues(alpha: 0.7),
      ),
    );
  }

  static final _buttonStyle = ButtonStyle(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: UIConstants.spacingXl, vertical: UIConstants.spacingLg),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.radiusMd),
      ),
    ),
    minimumSize: WidgetStateProperty.all(const Size(0, UIConstants.buttonHeight)),
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(style: _buttonStyle);

  static final _filledButtonTheme = FilledButtonThemeData(style: _buttonStyle);

  static final _textButtonTheme = TextButtonThemeData(style: _buttonStyle);

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      searchBarTheme: _searchBarTheme,
      listTileTheme: _listTileTheme(colorScheme),
      elevatedButtonTheme: _elevatedButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      textButtonTheme: _textButtonTheme,
    );
  }

  factory AppTheme.light() {
    return AppTheme(_buildTheme(Brightness.light));
  }

  factory AppTheme.dark() {
    return AppTheme(_buildTheme(Brightness.dark));
  }
}
