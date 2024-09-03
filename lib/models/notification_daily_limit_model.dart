class NotificationDailyLimitModel {
  int limit;

  NotificationDailyLimitModel({required this.limit});

  Map<String, dynamic> toJson() {
    return {'limit': limit};
  }

  factory NotificationDailyLimitModel.fromJson(Map<String, dynamic> map) {
    return NotificationDailyLimitModel(
      limit: map['limit'] != null ? map['limit'] as int : 0,
    );
  }
}
