import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageSource {
  String? getString(String key);
  Future<bool> setString(String key, String value);

  bool? getBool(String key);
  Future<bool> setBool(String key, bool value);

  int? getInt(String key);
  Future<bool> setInt(String key, int value);
}

@Singleton(as: StorageSource)
class StorageSourceSharedPrefsImpl extends StorageSource {
  late final SharedPreferences _instance;

  @PostConstruct()
  void init() async {
    _instance = await SharedPreferences.getInstance();
  }

  @override
  String? getString(String key) {
    return _instance.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _instance.setString(key, value);
  }

  @override
  bool? getBool(String key) {
    return _instance.getBool(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _instance.setBool(key, value);
  }

  @override
  int? getInt(String key) {
    return _instance.getInt(key);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return await _instance.setInt(key, value);
  }
}
