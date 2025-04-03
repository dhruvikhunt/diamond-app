import 'package:shared_preferences/shared_preferences.dart';

class AppPrefKeys {
  static String diamondData = 'diamondData';
  static String cartData = 'cartData';
}

class AppSharePref {
  static final AppSharePref _instance = AppSharePref._internal();
  SharedPreferences? _prefs;

  factory AppSharePref() {
    return _instance;
  }

  AppSharePref._internal();

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setIntData({required String keyName, required int value}) async {
    await _prefs?.setInt(keyName, value);
  }

  Future<void> setBoolData({
    required String keyName,
    required bool value,
  }) async {
    await _prefs?.setBool(keyName, value);
  }

  Future<void> setDoubleData({
    required String keyName,
    required double value,
  }) async {
    await _prefs?.setDouble(keyName, value);
  }

  Future<void> setStringData({
    required String keyName,
    required String value,
  }) async {
    await _prefs?.setString(keyName, value);
  }

  Future<void> setStringListData({
    required String keyName,
    required List<String> value,
  }) async {
    await _prefs?.setStringList(keyName, value);
  }

  Future<int> getIntData({required String keyName}) async {
    return _prefs?.getInt(keyName) ?? 0;
  }

  Future<bool> getBoolData({required String keyName}) async {
    return _prefs?.getBool(keyName) ?? false;
  }

  Future<double> getDoubleData({required String keyName}) async {
    return _prefs?.getDouble(keyName) ?? 0.0;
  }

  Future<String> getStringData({required String keyName}) async {
    return _prefs?.getString(keyName) ?? '';
  }

  Future<List<String>> getStringListData({required String keyName}) async {
    return _prefs?.getStringList(keyName) ?? [];
  }

  Future<void> removePrefKey({required String keyName}) async {
    await _prefs?.remove(keyName);
  }

  Future<void> clearPref({required String keyName}) async {
    await _prefs?.clear();
  }
}
