import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  static const String role = "role";
  static const String language = "language";
  static const String userId = "userId";
  //For getting and setting
  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefs = await _instance;
    return _prefs;
  }

  static Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);
  static bool? getBool(String key) => _prefs!.getBool(key);

  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);
  static String getString(String key) => _prefs!.getString(key) ?? "";

  static Future<bool> remove(String key) async => await _prefs!.remove(key);
}
