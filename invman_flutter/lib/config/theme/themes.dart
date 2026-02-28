import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invman_flutter/core/core.dart';

class AppTheme {
  final ThemeData themeData;

  AppTheme(this.themeData);

  static final _searchBarTheme = SearchBarThemeData(elevation: WidgetStateProperty.all(0.0));

  static const _seedColor = Colors.deepPurple;

  static ListTileThemeData _listTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: UIConstants.spacingLg, vertical: UIConstants.spacingXs),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIConstants.radiusMd)),
      tileColor: colorScheme.surfaceContainerLow,
      titleTextStyle: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface),
      subtitleTextStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.7)),
    );
  }

  static CardThemeData _cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIConstants.radiusMd)),
    );
  }

  static final _buttonStyle = ButtonStyle(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: UIConstants.spacingXl, vertical: UIConstants.spacingLg),
    ),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(UIConstants.radiusMd))),
    minimumSize: WidgetStateProperty.all(const Size(0, UIConstants.buttonHeight)),
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(style: _buttonStyle);

  static final _filledButtonTheme = FilledButtonThemeData(style: _buttonStyle);

  static final _textButtonTheme = TextButtonThemeData(style: _buttonStyle);

  static const _boldWeight = FontWeight.w600;

  static TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: _boldWeight),
      headlineMedium: base.headlineMedium?.copyWith(fontWeight: _boldWeight),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: _boldWeight),
      titleLarge: base.titleLarge?.copyWith(fontWeight: _boldWeight),
      titleMedium: base.titleMedium?.copyWith(fontWeight: _boldWeight),
      titleSmall: base.titleSmall?.copyWith(fontWeight: _boldWeight),
    );
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(seedColor: _seedColor, brightness: brightness);
    final baseTextTheme = brightness == Brightness.light ? ThemeData.light().textTheme : ThemeData.dark().textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: _textTheme(GoogleFonts.interTextTheme(baseTextTheme)),
      searchBarTheme: _searchBarTheme,
      cardTheme: _cardTheme(colorScheme),
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
