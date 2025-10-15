// import 'package:get/get.dart';
// import 'package:inprep_ai/core/services/shared_preferences_helper.dart'
//     show SharedPreferencesHelper;
// import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
// import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';

// class SplashScreenController extends GetxController {
//   @override
//   void onInit() {
//     navigateAfterDelay();
//     super.onInit();
//   }

//   void navigateAfterDelay() {
//     Future.delayed(Duration(seconds: 3), () async {
//       String? token = await SharedPreferencesHelper.getAccessToken();
//       if (token != null) {
//         Get.offAll(() => BottomNavbarView());
//       } else {
//         Get.offAll(() => Splash1Screen1());
//       }
//     });
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/home_screen/model/userinfo_model.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_setup.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';

class SplashScreenController extends GetxController {
  final RxBool isLoadingUser = false.obs;
  final Rx<UserInfo?> userInfo = Rx<UserInfo?>(null);

  Future<void> getUser() async {
    try {
      isLoadingUser.value = true;
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
      // You can log or handle the error here
    } finally {
      isLoadingUser.value = false;
      debugPrint("getUser API call finished.");
    }
  }

  @override
  void onInit() {
    navigateAfterDelay();
    super.onInit();
  }

  void navigateAfterDelay() async {
    Future.delayed(Duration(seconds: 3), () async {
      String? token = await SharedPreferencesHelper.getAccessToken();
      if (token != null) {
        await getUser();
        if (userInfo.value?.data?.isAboutMeGenerated == false) {
          Get.put(ProfileSetupController());
          Get.to(() => ProfileSetup());
        } else if (userInfo.value?.data?.isAboutMeGenerated == true) {
          Get.offAll(() => BottomNavbarView());
        }
      } else {
        // If no token, navigate to Splash1Screen1
        Get.offAll(() => Splash1Screen1());
      }
    });
  }
}
