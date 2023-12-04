import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static const String _currentMonthKey = 'currentMonth';

  static Future<void> saveCurrentMonth(String month) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentMonthKey, month);
  }

  static Future<String?> getCurrentMonth() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentMonthKey);
  }
}
