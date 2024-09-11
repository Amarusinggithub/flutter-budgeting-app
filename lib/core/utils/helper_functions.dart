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
    final now = DateTime.now();

    // Find the most recent Sunday (start of the current week)
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday % 7));

    // Calculate how many days have passed since Sunday
    final daysPassed = now.difference(firstDayOfWeek).inDays;

    return daysPassed; // This will be the number of days that have passed this week, including today
  }

  static int weekOfMonth(DateTime date) {
    // Get the first day of the current month
    final firstDayOfMonth = DateTime(date.year, date.month, 1);

    // Calculate the difference in days between the date and the first day of the month
    final daysSinceFirstDay = date.difference(firstDayOfMonth).inDays;

    // Calculate which week it is (ceil to account for incomplete weeks)
    return (daysSinceFirstDay / 7).ceil() +
        1; // Adding 1 to make the first week "Week 1"
  }

  static String capitalizeFirstLetterOfEachWord(String text) {
    if (text.isEmpty) return text;

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
