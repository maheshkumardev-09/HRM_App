import 'dart:convert';

import 'package:hrm_app/features/auth/models/user_moel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveUser(UserMoel user) async {
    final preference = await SharedPreferences.getInstance();
    String userjson = jsonEncode(user.toJson());
    await preference.setString("user", userjson);
    await preference.setBool("isLogin", true);
  }

  static Future<UserMoel?> getUser() async {
    final preference = await SharedPreferences.getInstance();
    String? data = preference.getString("user");
    if (data != null) {
      Map<String, dynamic> jsonData = jsonDecode(data);
      return UserMoel.formjson(jsonData);
    }
    return null;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }
}
