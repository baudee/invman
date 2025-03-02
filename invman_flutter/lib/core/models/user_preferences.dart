import 'package:flutter/material.dart';
import 'package:invman_flutter/core/models/app_theme_enum.dart';

class UserPreferencesState {
  final Locale locale;
  final AppThemeEnum theme;

  const UserPreferencesState({
    required this.locale,
    required this.theme,
  });

  UserPreferencesState copyWith({Locale? locale, AppThemeEnum? theme}) {
    return UserPreferencesState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
    );
  }
}
