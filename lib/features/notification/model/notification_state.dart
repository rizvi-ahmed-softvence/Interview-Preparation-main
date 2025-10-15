class NotificationStats {
  final String id;
  final int newNotification;
  final int oldNotificationCount;
  final int seenNotificationCount;

  NotificationStats({
    required this.id,
    required this.newNotification,
    required this.oldNotificationCount,
    required this.seenNotificationCount,
  });

  factory NotificationStats.fromJson(Map<String, dynamic> json) {
    return NotificationStats(
      id: json['_id'] ?? '',
      newNotification: json['newNotification'] ?? 0,
      oldNotificationCount: json['oldNotificationCount'] ?? 0,
      seenNotificationCount: json['seenNotificationCount'] ?? 0,
    );
  }
}

class NotificationResponse {
  final bool success;
  final String message;
  final NotificationStats data;

  NotificationResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: NotificationStats.fromJson(json['data']),
    );
  }
}