import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedpreferences;

  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future saveDate({
    required String key,
    required String value,
  }) async {
    return await sharedpreferences!.setString(key, value);
  }

  static String? getDate({
    required String key,
  }) {
    return sharedpreferences!.getString(key);
  }
}
