import 'package:flutter/material.dart';
import 'package:invman_flutter/core/models/app_theme_enum.dart';

class UserPreferencesState {
  final Locale locale;
  final AppThemeEnum theme;
  final bool sellerMode;

  const UserPreferencesState({
    required this.locale,
    required this.theme,
    required this.sellerMode,
  });

  UserPreferencesState copyWith({Locale? locale, AppThemeEnum? theme, bool? sellerMode}) {
    return UserPreferencesState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
      sellerMode: sellerMode ?? this.sellerMode,
    );
  }
}
