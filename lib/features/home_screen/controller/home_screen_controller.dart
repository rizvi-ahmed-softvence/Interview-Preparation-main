import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/home_screen/model/userinfo_model.dart';
import 'package:inprep_ai/features/notification/model/notification_state.dart';

class HomeScreenController extends GetxController {
  final RxBool isLoadingUser = false.obs;
  final Rx<UserInfo?> userInfo = Rx<UserInfo?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rx<NotificationResponse?> notificationResponse =
      Rx<NotificationResponse?>(null);

  // Method to reset the notification count
  void resetNotificationCount() {
    if (notificationResponse.value != null) {
      notificationResponse.value = NotificationResponse(
        success: notificationResponse.value!.success,
        message: notificationResponse.value!.message,
        data: NotificationStats(
          id: notificationResponse.value!.data.id,
          newNotification: 0, // Reset new notification count
          oldNotificationCount: notificationResponse.value!.data.oldNotificationCount,
          seenNotificationCount: notificationResponse.value!.data.seenNotificationCount,
        ),
      );
    }
  }

  //=======================================================================================
  Future<void> getUser() async {
    try {
      isLoadingUser.value = true;
      EasyLoading.show(status: "Loading user data...");
      debugPrint("Starting getUser API call...");

      // Retrieve the access token using the SharedPreferencesHelper
      String? accessToken = await SharedPreferencesHelper.getAccessToken();
      debugPrint(
        "Access token retrieved from SharedPreferencesHelper: $accessToken",
      );

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('No access token found in SharedPreferences.');
      }

      // Usually, APIs require 'Bearer <token>'
      final authHeader = accessToken;
      debugPrint("Authorization header set as: $authHeader");

      final Uri url = Uri.parse(Urls.getuser);
      debugPrint("GET Request URL: $url");

      final response = await http.get(
        url,
        headers: {
          'Authorization': authHeader,
          'Content-Type': 'application/json',
        },
      );

      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        debugPrint("Response JSON decoded.");

        if (responseData['success'] == true) {
          userInfo.value = UserInfo.fromJson(responseData);
          debugPrint("UserInfo parsed successfully.");
          debugPrint("User name: ${userInfo.value?.data?.name}");
          debugPrint("User email: ${userInfo.value?.data?.email}");
        } else {
          String message = responseData['message'] ?? 'Unknown error from API';
          debugPrint("API responded with success=false: $message");
          throw Exception('Failed to fetch user data: $message');
        }
      } else {
        throw Exception(
          'Failed to load user data, status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Exception caught in getUser(): $e");
      EasyLoading.showError("Failed to load user data: ${e.toString()}");
    } finally {
      isLoadingUser.value = false;
      EasyLoading.dismiss();
      debugPrint("getUser API call finished.");
    }
  }

  //========================================================================================
  Future<void> fetchNotificationStats() async {
    try {
      isLoading(true);
      error('');
      final response = await getNotificationStats(); // Your existing API call
      notificationResponse(response);
    } catch (e) {
      error(e.toString());
      notificationResponse(null);
    } finally {
      isLoading(false);
    }
  }

  int get newNotificationCount {
    return notificationResponse.value?.data.newNotification ?? 0;
  }

  Future<NotificationResponse> getNotificationStats() async {
    const String functionName = 'getNotificationStats';
    debugPrint('[$functionName] ⏳ Starting function execution');

    try {
      // 1. Get access token
      debugPrint('[$functionName] 🔍 Retrieving access token...');
      final String? accessToken =
          await SharedPreferencesHelper.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        const String errorMsg = 'Access token not found or empty';
        debugPrint('[$functionName] ❌ $errorMsg');
        throw Exception(errorMsg);
      }

      // Mask token for security in logs (show first and last 4 chars)
      final maskedToken =
          '${accessToken.substring(0, 4)}...${accessToken.substring(accessToken.length - 4)}';
      debugPrint('[$functionName] 🔑 Using access token: $maskedToken');

      // 2. Prepare request
      final url = Uri.parse(Urls.notification);
      debugPrint('[$functionName] 🌐 API Endpoint: ${url.toString()}');

      // 3. Make HTTP request
      debugPrint('[$functionName] 🚀 Sending GET request...');
      final response = await http
          .get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': accessToken, // Added Bearer prefix
            },
          )
          .timeout(const Duration(seconds: 30)); // Added timeout

      debugPrint(
        '[$functionName] ✅ Received response - Status: ${response.statusCode}',
      );
      debugPrint('[$functionName] 📦 Response body: ${response.body}');

      // 4. Handle response
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        try {
          final notificationResponse = NotificationResponse.fromJson(
            responseData,
          );
          debugPrint('[$functionName] ✔️ Successfully parsed response');
          return notificationResponse;
        } catch (e) {
          debugPrint('[$functionName] ❌ Response parsing failed: $e');
          throw Exception('Failed to parse notification data');
        }
      } else {
        final errorMsg =
            responseData['message'] as String? ??
            'Request failed with status ${response.statusCode}';
        debugPrint('[$functionName] ❌ Error: $errorMsg');
        throw Exception(errorMsg);
      }
    } on TimeoutException {
      const String errorMsg = 'Request timed out';
      debugPrint('[$functionName] ❌ $errorMsg');
      throw Exception(errorMsg);
    } on FormatException catch (e) {
      debugPrint('[$functionName] ❌ JSON parsing error: $e');
      throw Exception('Invalid server response format');
    } on http.ClientException catch (e) {
      debugPrint('[$functionName] ❌ Network error: $e');
      throw Exception('Network connection failed. Please check your internet.');
    } on Exception catch (e) {
      debugPrint('[$functionName] ❌ Unexpected error: $e');
      rethrow; // Preserve original exception
    } finally {
      debugPrint('[$functionName] 🏁 Function execution completed');
    }
  }

  //========================================================================================

  @override
  void onInit() {
    getUser();
    fetchNotificationStats();
    super.onInit();
  }
}
