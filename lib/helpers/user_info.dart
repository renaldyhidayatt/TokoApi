import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  Future setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString("token", token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  Future setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString("userId", userId);
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId") ?? "";
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future setNama(String nama) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString("nama", nama);
  }

  Future<String> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("nama") ?? "";
  }

  Future setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.setString("email", email);
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? "";
  }
}
