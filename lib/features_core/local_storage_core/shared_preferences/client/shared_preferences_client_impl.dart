import 'package:flutter/foundation.dart';
import 'package:search_series/features_core/local_storage_core/local_storage_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClientImpl implements SharedPreferencesClient {

  @override
  Future<String?> getString(String key) async {
    debugPrint('******** sharedPreferencesInstance.getString: $key');
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    debugPrint('******** sharedPreferencesInstance.setString: $key, $value');
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return await instance.setString(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    debugPrint('******** sharedPreferencesInstance.getBool: $key');
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.getBool(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    debugPrint('******** sharedPreferencesInstance.setBool: $key, $value');
    final SharedPreferences instance = await SharedPreferences.getInstance();
    return await instance.setBool(key, value);
  }
}
