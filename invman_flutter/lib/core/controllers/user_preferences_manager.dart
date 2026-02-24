import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_flutter/core/repositories/user_preferences_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

@singleton
class UserPreferencesManager {
  final UserPreferencesRepository _repository;

  late final FlutterSignal<Locale> locale = signal<Locale>(_repository.getLocale());
  late final FlutterSignal<ThemeMode> theme = signal<ThemeMode>(_repository.getTheme());

  UserPreferencesManager({required UserPreferencesRepository repository}) : _repository = repository {
    initializeDateFormatting(locale.value.toLanguageTag(), null);
  }

  Future<String?> setLocale(Locale locale) async {
    final result = await _repository.setLocale(locale);
    return result.fold((error) => error, (locale) async {
      this.locale.value = locale;
      await initializeDateFormatting(locale.toLanguageTag(), null);
      return null;
    });
  }

  Future<String?> setTheme(ThemeMode theme) async {
    final result = await _repository.setTheme(theme);
    return result.fold((error) => error, (theme) {
      this.theme.value = theme;
      return null;
    });
  }
}
