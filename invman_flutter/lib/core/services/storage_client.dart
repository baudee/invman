import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageClient {
  static const languageKey = "language";
  static const themeKey = "theme";
  static const emailKey = "email";
  static const sellerModeKey = "sellerMode";

  Future<void> init();

  String? getString(String key);
  Future<bool> setString(String key, String value);

  bool? getBool(String key);
  Future<bool> setBool(String key, bool value);

  int? getInt(String key);
  Future<bool> setInt(String key, int value);
}

class StorageClientSharedPrefsImpl extends StorageClient {
  late final SharedPreferences _instance;

  @override
  Future<void> init() async {
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
