import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inprep_ai/features/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final String _readNotificationsKey = 'read_notifications';

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // Fetch notifications from the API
  Future<void> fetchNotifications() async {
    // Start the loading indicator
    isLoading.value = true;
    errorMessage.value = '';
    debugPrint('Fetching notifications...');

    try {
      // Retrieve the access token
      String? accessToken = await SharedPreferencesHelper.getAccessToken();
      debugPrint('Access Token: $accessToken');

      // Check if access token is null or empty
      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        debugPrint('Access token is missing.');
        return;
      }

      // Make the GET request to fetch notifications
      final response = await http.get(
        Uri.parse(Urls.allnotification),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );

      // Print the response status code and body
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonResponse = json.decode(response.body);
        debugPrint('Parsed JSON Response: $jsonResponse');

        // Map the response to the AllNotification model
        final allNotification = AllNotification.fromJson(jsonResponse);
        debugPrint(
          'All Notifications Data: ${allNotification.data.notificationList.length} notifications found.',
        );

        // Load the read notifications
        final readNotifications = await _loadReadNotifications();
        debugPrint('Read Notifications: $readNotifications');

        // Update the notifications list with data
        notifications.assignAll(
          allNotification.data.notificationList.map((notif) {
            final isRead = readNotifications.contains(notif.id) || notif.isSeen;
            debugPrint('Notification ID: ${notif.id}, Is Read: $isRead');
            return NotificationItem(
              id: notif.id,
              message: notif.notificationDetail,
              timeAgo: _formatTimeAgo(notif.createdAt),
              imageUrl: 'https://placehold.co/48x48',
              read: isRead,
            );
          }),
        );
        debugPrint(
          'Notifications Updated: ${notifications.length} notifications added.',
        );
      } else {
        // Handle unsuccessful response
        errorMessage.value = 'Error: ${response.statusCode}';
        debugPrint(
          'Failed to fetch notifications. Error Code: ${response.statusCode}',
        );
        notifications.clear();
      }
    } catch (e) {
      // Handle any errors
      errorMessage.value = 'Failed to fetch data: $e';
      debugPrint('Exception: $e');
      notifications.clear();
    } finally {
      // Stop the loading indicator
      isLoading.value = false;
      debugPrint('Fetch Notifications completed.');
    }
  }

  // Mark all notifications as read
  Future<void> markAllAsRead() async {
    final readIds = notifications.map((n) => n.id).toSet();
    await _saveReadNotifications(readIds);
    for (final notification in notifications) {
      notification.isRead.value = true;
    }
  }

  // Mark a specific notification as read and update the backend
  Future<void> markAsRead(String id) async {
    final notif = notifications.firstWhereOrNull((n) => n.id == id);
    if (notif != null) {
      final readNotifications = await _loadReadNotifications();
      readNotifications.add(id);
      await _saveReadNotifications(readNotifications);
      notif.isRead.value = true;
    }
  }

  // Mark a specific notification as viewed via API
  Future<void> markNotificationAsViewed(String notificationId) async {
  isLoading.value = true;

  try {
    final String? accessToken = await SharedPreferencesHelper.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      EasyLoading.showError("Access token is missing. Please login again.");
      debugPrint('Access token is missing.');
      return;
    }

    // Print the notificationId for debugging
    debugPrint('Marking notification with ID: $notificationId');

    // API URL with notification_id as query parameter
    final url = Uri.parse(
      'https://ai-interview-server-s2a5.onrender.com/api/v1/notifications/viewSpecificNotification?notification_id=$notificationId',
    );

    // Make POST request with the appropriate headers
    final response = await http.get(
      url,
      headers: {
        'Authorization': accessToken, // Ensure correct Authorization header format
        'Content-Type': 'application/json',
      },
    );

    // Print the response status code and body for debugging
    debugPrint('Response Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    // Check if the response is successful
    if (response.statusCode == 200) {
      debugPrint('Notification marked as viewed: $notificationId');
    } else {
      // Handle failed request
      debugPrint(
        'Failed to mark notification as viewed. Status code: ${response.statusCode}, Response Body: ${response.body}',
      );
    }
  } catch (e) {
    debugPrint('Error marking notification as viewed: $e');
  } finally {
    isLoading.value = false;
  }
}


  // Helper method to load the read notifications from SharedPreferences
  Future<Set<String>> _loadReadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final readNotificationsJson = prefs.getString(_readNotificationsKey);
    return readNotificationsJson != null
        ? Set<String>.from(json.decode(readNotificationsJson) as List)
        : <String>{};
  }

  // Helper method to save read notifications to SharedPreferences
  Future<void> _saveReadNotifications(Set<String> readIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_readNotificationsKey, json.encode(readIds.toList()));
  }

  // Helper method to format the time difference into a human-readable format
  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}
