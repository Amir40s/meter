import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  static const String role = "role";
  static const String language = "language";
  static const String userId = "userId";

  // Singleton pattern for SharedPreferences
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  // Call this method from the initState() function of the main app.
  static Future<SharedPreferences?> init() async {
    _prefs = await _instance;
    return _prefs;
  }

  static Future<bool> setBool(String key, bool value) async {
    final prefs = await _instance;
    return await prefs.setBool(key, value);
  }

  static bool? getBool(String key) => _prefs?.getBool(key);

  static Future<bool> setString(String key, String value) async {
    final prefs = await _instance;
    return await prefs.setString(key, value);
  }

  static String getString(String key) => _prefs?.getString(key) ?? "";

  static Future<bool> remove(String key) async {
    log('message::remove  $key');
    final prefs = await _instance;
    return await prefs.remove(key);
  }
}
