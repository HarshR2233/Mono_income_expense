import 'package:intl/intl.dart';

class MonthUtils {
  static String getCurrentMonth() {
    return DateFormat('MM').format(DateTime.now());
  }
}
