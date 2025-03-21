import 'package:flutter/material.dart';
import 'package:invman_flutter/core/models/app_theme_enum.dart';

class UserPreferencesState {
  final Locale locale;
  final AppThemeEnum theme;
  final String currency;

  const UserPreferencesState({
    required this.locale,
    required this.theme,
    required this.currency,
  });

  UserPreferencesState copyWith({Locale? locale, AppThemeEnum? theme, String? currency}) {
    return UserPreferencesState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
      currency: currency ?? this.currency,
    );
  }
}
