import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:invman_flutter/features/app_settings/repositories/app_settings_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum AppSettingsStatus { loading, ok, maintenance, updateRequired }

@singleton
class AppSettingsManager {
  final AppSettingsRepository _repository;

  final Signal<AppSettingsStatus> status = signal(AppSettingsStatus.loading);
  final Signal<String?> storeUrl = signal(null);

  AppSettingsManager(this._repository) {
    check();
  }

  Future<void> check() async {
    status.value = AppSettingsStatus.loading;

    final settings = await _repository.get();

    settings.fold(
      (error) {
        status.value = AppSettingsStatus.ok;
      },
      (settings) async {
        if (settings.maintenanceMode) {
          status.value = AppSettingsStatus.maintenance;
          return;
        }

        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        if (_isVersionLower(currentVersion, settings.minVersion)) {
          storeUrl.value = Platform.isIOS ? settings.appStoreUrl : settings.playStoreUrl;
          status.value = AppSettingsStatus.updateRequired;
          return;
        }

        status.value = AppSettingsStatus.ok;
      },
    );
  }

  bool _isVersionLower(String current, String min) {
    final currentParts = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    final minParts = min.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    while (currentParts.length < 3) {
      currentParts.add(0);
    }
    while (minParts.length < 3) {
      minParts.add(0);
    }

    for (var i = 0; i < 3; i++) {
      if (currentParts[i] < minParts[i]) return true;
      if (currentParts[i] > minParts[i]) return false;
    }
    return false;
  }
}
