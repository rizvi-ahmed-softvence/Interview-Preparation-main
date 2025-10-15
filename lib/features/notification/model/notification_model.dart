import 'package:get/get_rx/src/rx_types/rx_types.dart';

class NotificationItem {
  final String id;
  final String message;
  final String timeAgo;
  final String imageUrl;
  final RxBool isRead;

  NotificationItem({
    required this.id,
    required this.message,
    required this.timeAgo,
    required this.imageUrl,
    required bool read,
  }) : isRead = read.obs;

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'timeAgo': timeAgo,
        'imageUrl': imageUrl,
        'isRead': isRead.value,
      };

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      message: json['message'],
      timeAgo: json['timeAgo'],
      imageUrl: json['imageUrl'],
      read: json['isRead'],
    );
  }
}

class AllNotification {
  final bool success;
  final String message;
  final Data data;

  AllNotification({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllNotification.fromJson(Map<String, dynamic> json) {
    return AllNotification(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: Data.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class Data {
  final List<NotificationList> notificationList;

  Data({
    required this.notificationList,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      notificationList: (json['notificationList'] as List<dynamic>?)
              ?.map((e) => NotificationList.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class NotificationList {
  final String id;
  final String notificationDetail;
  final bool isSeen;
  final DateTime createdAt;

  NotificationList({
    required this.id,
    required this.notificationDetail,
    required this.isSeen,
    required this.createdAt,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    return NotificationList(
      id: json['_id'] as String? ?? '',
      notificationDetail: json['notificationDetail'] as String? ?? '',
      isSeen: json['isSeen'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}