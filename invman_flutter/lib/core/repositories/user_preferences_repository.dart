import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/config/generated/l10n.dart';
import 'package:invman_flutter/core/core.dart';

@injectable
class UserPreferencesRepository {
  final StorageSource _storage;

  static const languageKey = "language";
  static const themeKey = "theme";
  static const emailKey = "email";

  UserPreferencesRepository({required StorageSource storage}) : _storage = storage;

  Locale getLocale() {
    String localeName = "";
    String languageCode = "";

    final savedLanguage = _storage.getString(UserPreferencesRepository.languageKey);

    if (savedLanguage != null) {
      languageCode = savedLanguage;
    } else {
      try {
        localeName = Platform.localeName;
      } catch (e) {
        localeName = "en_US";
      }

      languageCode = localeName.split('_').first.toLowerCase();
      _storage.setString(UserPreferencesRepository.languageKey, languageCode);
    }
    if (!SupportedLanguage.values.map((e) => e.languageName).toList().contains(languageCode)) {
      languageCode = "en";
    }

    return Locale.fromSubtags(languageCode: languageCode);
  }

  Future<Either<String, Locale>> setLocale(Locale locale) async {
    String languageCode = locale.languageCode.split('_').first.toLowerCase();
    final success = await _storage.setString(UserPreferencesRepository.languageKey, languageCode);
    if (success) {
      return right(Locale.fromSubtags(languageCode: languageCode));
    }
    return left(S.current.error_code(ErrorCode.unknown));
  }

  ThemeMode getTheme() {
    final savedTheme = _storage.getString(UserPreferencesRepository.themeKey);
    if (savedTheme != null) {
      return ThemeMode.values.firstWhere((e) => e.name == savedTheme, orElse: () => ThemeMode.dark);
    }
    return ThemeMode.dark;
  }

  Future<Either<String, ThemeMode>> setTheme(ThemeMode theme) async {
    final success = await _storage.setString(UserPreferencesRepository.themeKey, theme.name);
    if (success) {
      return right(theme);
    }
    return left(S.current.error_code(ErrorCode.unknown));
  }

  String? getEmail() {
    return _storage.getString(UserPreferencesRepository.emailKey);
  }

  Future<Either<String, String?>> setEmail(String email) async {
    final success = await _storage.setString(UserPreferencesRepository.emailKey, email);
    if (success) {
      return right(email);
    }
    return left(S.current.error_code(ErrorCode.unknown));
  }
}
