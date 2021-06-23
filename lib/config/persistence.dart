import 'package:shared_preferences/shared_preferences.dart';

class Persistence {
  static Future<String> load() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return (prefs.getString('store') ?? "");
    } catch (err) {
      return "";
    }
  }

  static Future<bool> store(String content) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('store', content);
      return true;
    } catch (err) {
      return false;
    }
  }
}
