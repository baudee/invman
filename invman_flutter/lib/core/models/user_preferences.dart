import 'package:flutter/material.dart';

class UserPreferencesState {
  final Locale locale;
  final ThemeMode theme;
  final String currency;

  const UserPreferencesState({
    required this.locale,
    required this.theme,
    required this.currency,
  });

  UserPreferencesState copyWith({Locale? locale, ThemeMode? theme, String? currency}) {
    return UserPreferencesState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
      currency: currency ?? this.currency,
    );
  }
}
