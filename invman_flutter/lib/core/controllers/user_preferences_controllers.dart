import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/core/core.dart';
import 'package:signals_flutter/signals_flutter.dart';

@singleton
class UserPreferencesController {
  final StorageClient _storage;

  late final FlutterSignal<Locale> locale = signal<Locale>(_initLocale());
  late final FlutterSignal<ThemeMode> theme = signal<ThemeMode>(_initTheme());

  UserPreferencesController({required StorageClient storage}) : _storage = storage;

  Locale _initLocale() {
    String localeName = "";
    String languageCode = "";

    final savedLanguage = _storage.getString(StorageClient.languageKey);

    if (savedLanguage != null) {
      languageCode = savedLanguage;
    } else {
      try {
        localeName = Platform.localeName;
      } catch (e) {
        localeName = "en_US";
      }

      languageCode = localeName.split('_').first.toLowerCase();
      _storage.setString(StorageClient.languageKey, languageCode);
    }
    if (!SupportedLanguage.values.map((e) => e.languageName).toList().contains(languageCode)) {
      languageCode = "en";
    }

    return Locale.fromSubtags(languageCode: languageCode);
  }

  void setLocale(Locale locale) {
    this.locale.value = locale;

    String languageCode = locale.languageCode.split('_').first.toLowerCase();
    _storage.setString(StorageClient.languageKey, languageCode);
  }

  ThemeMode _initTheme() {
    final savedTheme = _storage.getString(StorageClient.themeKey);
    if (savedTheme != null) {
      return ThemeMode.values.firstWhere((e) => e.name == savedTheme, orElse: () => ThemeMode.system);
    }
    return ThemeMode.system;
  }

  void setTheme(ThemeMode theme) {
    this.theme.value = theme;
    _storage.setString(StorageClient.themeKey, theme.name);
  }
}
