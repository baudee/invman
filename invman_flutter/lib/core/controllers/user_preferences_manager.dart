import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:invman_client/invman_client.dart';
import 'package:invman_flutter/core/repositories/user_preferences_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

@singleton
class UserPreferencesManager {
  final UserPreferencesRepository _repository;

  late final FlutterSignal<Locale> _locale = signal<Locale>(_repository.getLocale());
  ReadonlySignal<Locale> get locale => _locale;
  late final FlutterSignal<ThemeMode> _theme = signal<ThemeMode>(_repository.getTheme());
  ReadonlySignal<ThemeMode> get theme => _theme;
  late final FlutterSignal<AssetTimeHorizon> _assetTimeHorizon = signal<AssetTimeHorizon>(AssetTimeHorizon.oneWeek);
  ReadonlySignal<AssetTimeHorizon> get assetTimeHorizon => _assetTimeHorizon;
  late final FlutterSignal<InvestmentReturnInterval> _investmentReturnInterval = signal<InvestmentReturnInterval>(
    InvestmentReturnInterval.monthly,
  );
  ReadonlySignal<InvestmentReturnInterval> get investmentReturnInterval => _investmentReturnInterval;

  UserPreferencesManager({required UserPreferencesRepository repository}) : _repository = repository {
    initializeDateFormatting(_locale.value.toLanguageTag(), null);
  }

  Future<String?> setLocale(Locale locale) async {
    final result = await _repository.setLocale(locale);
    return result.fold((error) => error, (locale) async {
      _locale.value = locale;
      await initializeDateFormatting(locale.toLanguageTag(), null);
      return null;
    });
  }

  Future<String?> setTheme(ThemeMode theme) async {
    final result = await _repository.setTheme(theme);
    return result.fold((error) => error, (theme) {
      _theme.value = theme;
      return null;
    });
  }

  void setAssetTimeHorizon(AssetTimeHorizon timeHorizon) {
    _assetTimeHorizon.value = timeHorizon;
  }

  void setInvestmentReturnInterval(InvestmentReturnInterval interval) {
    _investmentReturnInterval.value = interval;
  }
}
