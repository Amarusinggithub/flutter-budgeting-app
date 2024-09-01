import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/notification_daily_limit_model.dart';

class NotificationService extends ChangeNotifier {
  final FirebaseAuth auth;

  NotificationService({
    required this.auth,
  });

  void scheduleNotification(int num) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'scheduled_channel',
        title: 'Add Today\'s Transactions',
        body: 'Please add today transactions',
      ),
      schedule: NotificationInterval(
        interval: num * 60 * 60,
        timeZone: AwesomeNotifications.localTimeZoneIdentifier,
        repeats: true,
      ),
    );
  }

  Future<void> updateNotificationDailyLimit(
      NotificationDailyLimitModel limit) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      Map<String, dynamic> notificationLimitJson = limit.toJson();

      await firestore.collection('users').doc(userId).update({
        'Notification daily Limit': notificationLimitJson,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error updating notification daily limit in database: $e");
      }
    }
  }

  Future<NotificationDailyLimitModel?> fetchNotificationDailyLimit() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String userId = auth.currentUser!.uid;

      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('Notification daily Limit')) {
          dynamic notificationLimitJson = data['Notification daily Limit'];
          NotificationDailyLimitModel notificationLimit =
              NotificationDailyLimitModel.fromJson(
                  notificationLimitJson as Map<String, dynamic>);

          if (kDebugMode) {
            print(
                "Fetched notification limit model from database: $notificationLimit");
          }
          return notificationLimit;
        }
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching notification limit from database: $e");
      }

      return null;
    }
  }
}
