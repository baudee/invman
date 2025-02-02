import 'dart:io';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:invman_flutter/features/auth/auth.dart';

part 'user_preferences_provider.g.dart';

@Riverpod(keepAlive: true)
class UserPreferences extends _$UserPreferences {
  @override
  UserPreferencesState build() {
    final locale = _initLocale();
    final theme = _initTheme();
    final sellerMode = _initSellerMode();

    return UserPreferencesState(locale: locale, theme: theme, sellerMode: sellerMode);
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
    if (!['en', 'es'].contains(languageCode)) {
      languageCode = "en";
    }

    return Locale.fromSubtags(languageCode: languageCode);
  }

  AppThemeEnum _initTheme() {
    final savedTheme = ref.read(storageProvider).getString(StorageClient.themeKey);
    if (savedTheme != null) {
      return AppThemeEnum.values.firstWhere((e) => e.value == savedTheme, orElse: () => AppThemeEnum.system);
    }
    return AppThemeEnum.system;
  }

  bool _initSellerMode() {
    ref.listen(
      authProvider,
      (previous, next) {
        if (previous is AuthStateSuccess && next is! AuthStateSuccess) {
          // Deconnexion case
          setSellerMode(false);
        } else if (previous is! AuthStateSuccess && next is AuthStateSuccess) {
          // Connection case
          final savedSellerMode = ref.read(storageProvider).getBool(StorageClient.sellerModeKey);
          setSellerMode(savedSellerMode ?? false);
        }
      },
    );

    final authState = ref.read(authProvider);
    if (authState is! AuthStateSuccess) {
      return false;
    }
    final savedSellerMode = ref.read(storageProvider).getBool(StorageClient.sellerModeKey);
    return savedSellerMode ?? false;
  }

  void setLocale(Locale locale) {
    state = state.copyWith(locale: locale);

    String languageCode = locale.languageCode.split('_').first.toLowerCase();
    ref.read(storageProvider).setString(StorageClient.languageKey, languageCode);
  }

  void setTheme(AppThemeEnum theme) {
    state = state.copyWith(theme: theme);
    ref.read(storageProvider).setString(StorageClient.themeKey, theme.value);
  }

  void setSellerMode(bool sellerMode) {
    state = state.copyWith(sellerMode: sellerMode);
    ref.read(storageProvider).setBool(StorageClient.sellerModeKey, sellerMode);
  }
}
