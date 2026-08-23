import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static Future<void> saveLoginSession(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("loggedUserId", userId);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  static Future<String?> getLoggedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loggedUserId");
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false);
    await prefs.remove("loggedUserId");
  }
}
