import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/core/core.dart';

part 'user_preferences_provider.g.dart';

@Riverpod(keepAlive: true)
class UserPreferences extends _$UserPreferences {
  @override
  UserPreferencesState build() {
    final locale = _initLocale();
    final theme = _initTheme();
    final currency = _initCurrency();

    return UserPreferencesState(
      locale: locale,
      theme: theme,
      currency: currency,
    );
  }

  Locale _initLocale() {
    String localeName = "";
    String languageCode = "";

    final savedLanguage = ref.read(storageProvider).getString(StorageClient.languageKey);

    if (savedLanguage != null) {
      languageCode = savedLanguage;
    } else {
      try {
        localeName = Platform.localeName;
      } catch (e) {
        localeName = "en_US";
      }

      languageCode = localeName.split('_').first.toLowerCase();
      ref.read(storageProvider).setString(StorageClient.languageKey, languageCode);
    }
    if (!SupportedLanguage.values.map((e) => e.languageName).toList().contains(languageCode)) {
      languageCode = "en";
    }

    return Locale.fromSubtags(languageCode: languageCode);
  }

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);

    String languageCode = locale.languageCode.split('_').first.toLowerCase();
    ref.read(storageProvider).setString(StorageClient.languageKey, languageCode);
  }

  AppThemeEnum _initTheme() {
    final savedTheme = ref.read(storageProvider).getString(StorageClient.themeKey);
    if (savedTheme != null) {
      return AppThemeEnum.values.firstWhere((e) => e.value == savedTheme, orElse: () => AppThemeEnum.system);
    }
    return AppThemeEnum.system;
  }

  void setTheme(AppThemeEnum theme) {
    state = state.copyWith(theme: theme);
    ref.read(storageProvider).setString(StorageClient.themeKey, theme.value);
  }

  String _initCurrency() {
    return "CHF";
  }
}
