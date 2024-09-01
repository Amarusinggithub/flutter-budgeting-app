import 'package:budgetingapp/models/notification_daily_limit_model.dart';
import 'package:budgetingapp/services/notification_service.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationDailyLimitModel? notificationDailyLimitModel;
  NotificationService notificationService;

  List<int> dailyLimits = [1, 2, 3, 4, 5, 6];
  int selectedLimitIndex = 2;

  NotificationProvider({required this.notificationService});

  Future<void> fetchNotificationDailyLimit() async {
    NotificationDailyLimitModel? fetchedNotificationDailyLimitModel =
        await notificationService.fetchNotificationDailyLimit();
    if (notificationDailyLimitModel == null &&
        fetchedNotificationDailyLimitModel != null) {
      notificationDailyLimitModel = fetchedNotificationDailyLimitModel;
    } else {
      notificationDailyLimitModel = NotificationDailyLimitModel(limit: 3);
    }
  }

  void updateSelectLimit(int updatedSelectedLimit) {
    selectedLimitIndex = updatedSelectedLimit;
    notifyListeners();
  }
}
