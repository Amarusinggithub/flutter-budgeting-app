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

    // Get the first day of the current month
    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    // Calculate the difference in days between now and the first day of the month
    final dayOfMonth = now.difference(firstDayOfMonth).inDays +
        1; // Add 1 to account for the first day being the 1st

    // Calculate the current week of the month
    final currentWeek =
        (dayOfMonth / 7).ceil(); // Ceil to get the correct week number

    return currentWeek;
  }

  static int daysPassedInCurrentWeek() {
    // Get the current date and time
    final now = DateTime.now();

    // Get the current week of the month using your existing function
    final currentWeek = getCurrentWeekOfMonth();

    // Get the first day of the current month
    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    // Calculate which day of the month the first day of the current week is
    final firstDayOfWeek =
        firstDayOfMonth.add(Duration(days: (currentWeek - 1) * 7));

    // If today's date is earlier than the first day of the current week, return the difference
    if (now.isBefore(firstDayOfWeek)) {
      return 0;
    }

    // Calculate how many days have passed since the first day of the current week
    final daysPassed = now.difference(firstDayOfWeek).inDays + 1;

    return daysPassed;
  }

  static int weekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return (daysSinceFirstDay / 7).ceil();
  }

  static String capitalizeFirstLetterOfEachWord(String text) {
    if (text.isEmpty) return text;

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
