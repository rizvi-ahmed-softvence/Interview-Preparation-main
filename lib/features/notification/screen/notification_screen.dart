import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/notification/controller/notification_controller.dart';
import 'package:inprep_ai/features/notification/model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: notificationController.markAllAsRead,
                  child: Text(
                    'Mark all as read',
                    style: getTextStyle(
                      color: const Color(0xff6a329f),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (notificationController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (notificationController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(notificationController.errorMessage.value));
              }

              if (notificationController.notifications.isEmpty) {
                return const Center(child: Text('No notifications'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notificationController.notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notification = notificationController.notifications[index];
                  return _buildNotificationItem(notification, context);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show dialog with full message
        showDialog(
          context: context,
          
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Notification Details'),
              content: Text(notification.message),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        // Mark the notification as read in the backend
        await notificationController.markNotificationAsViewed(notification.id);

        // Optionally, update the UI to reflect that the notification is read
        notification.isRead.value = true;
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead.value
                ? Colors.white
                : const Color(0xFF6a329f).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: notification.isRead.value
                    ? Colors.grey[300]
                    : const Color(0xFF6a329f),
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/icons/notification.png',
                    image: notification.imageUrl,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          notification.message.length >= 2
                              ? notification.message.substring(0, 2).toUpperCase()
                              : notification.message.toUpperCase(),
                          style: getTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  notification.message,
                  style: getTextStyle(
                    color: notification.isRead.value
                        ? const Color(0xFF333333)
                        : const Color(0xFF0D3C6B),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                notification.timeAgo,
                style: getTextStyle(
                  color: const Color(0xFF475569),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
