import 'package:budgetingapp/models/notification_daily_limit_model.dart';
import 'package:budgetingapp/services/notification_service.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationDailyLimitModel? notificationDailyLimitModel;
  NotificationService notificationService;

  List<int> dailyLimits = [0, 1, 2, 3, 4, 5, 6];
  int selectedLimitIndex = 2;

  NotificationProvider({required this.notificationService}) {
    initialize();
  }

  Future<void> initialize() async {
    await fetchNotificationDailyLimit();
    notifyListeners();
  }

  Future<void> fetchNotificationDailyLimit() async {
    NotificationDailyLimitModel? fetchedNotificationDailyLimitModel =
        await notificationService.fetchNotificationDailyLimit();
    if (notificationDailyLimitModel == null &&
        fetchedNotificationDailyLimitModel != null) {
      notificationDailyLimitModel = fetchedNotificationDailyLimitModel;
      selectedLimitIndex =
          dailyLimits.indexOf(notificationDailyLimitModel!.limit);
    } else {
      await createNewNotificationLimit();
    }
  }

  Future<void> createNewNotificationLimit() async {
    NotificationDailyLimitModel newNotificationDailyLimitModel =
        NotificationDailyLimitModel(limit: 3);
    notificationDailyLimitModel = newNotificationDailyLimitModel;
    if (kDebugMode) {
      print(
          "Created new notificationlimitmodel: ${notificationDailyLimitModel?.limit}");
    }
    notifyListeners();
  }

  void updateSelectLimit(int index) {
    selectedLimitIndex = index;
    notificationDailyLimitModel?.limit = dailyLimits[selectedLimitIndex];
    if (selectedLimitIndex == 0) {
      updateNotificationDailyLimit();
    } else {
      notificationService
          .scheduleNotification(notificationDailyLimitModel!.limit);
      notificationService.immediateNotification();
      updateNotificationDailyLimit();
    }

    notifyListeners();
  }

  Future<void> updateNotificationDailyLimit() async {
    await notificationService
        .updateNotificationDailyLimit(notificationDailyLimitModel!);
  }
}
