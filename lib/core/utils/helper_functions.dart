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

  static int getCurrentWeekOfMonth() {
    final now = DateTime.now();

    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    final dayOfMonth = now.difference(firstDayOfMonth).inDays + 1;

    // Calculate the current week of the month
    final currentWeek = (dayOfMonth / 7).ceil();

    return currentWeek;
  }

  static int daysPassedInCurrentWeek() {
    final now = DateTime.now();

    final firstDayOfWeek = now.subtract(Duration(days: now.weekday % 7));

    final daysPassed = now.difference(firstDayOfWeek).inDays;

    return daysPassed;
  }

  static int weekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);

    final daysSinceFirstDay = date.difference(firstDayOfMonth).inDays;

    return (daysSinceFirstDay / 7).ceil() + 1;
  }

  static String capitalizeFirstLetterOfEachWord(String text) {
    if (text.isEmpty) return text;

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
