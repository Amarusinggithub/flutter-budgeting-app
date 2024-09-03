import 'package:intl/intl.dart';

class HelperFunctions {
  static bool isStartOfMonth() {
    DateTime today = DateTime.now();
    return today.day == 1;
  }

  static bool isEndOfMonthAndDay() {
    DateTime today = DateTime.now();
    DateTime lastDayOfMonth = DateTime(today.year, today.month + 1, 0);
    bool isEndOfMonth = today.day == lastDayOfMonth.day;
    bool isEndOfDay = today.hour == 23 && today.minute == 59;
    return isEndOfMonth && isEndOfDay;
  }

  static String numberCurrencyFormatter(double number) {
    final formatCurrency = NumberFormat.simpleCurrency();
    return formatCurrency.format(number);
  }

  static String formatTime(int epochMillis) {
    final DateTime parsedTime =
        DateTime.fromMillisecondsSinceEpoch(epochMillis);

    final String formattedTime =
        DateFormat('h:m a', 'en_US').format(parsedTime);

    return formattedTime;
  }
}
