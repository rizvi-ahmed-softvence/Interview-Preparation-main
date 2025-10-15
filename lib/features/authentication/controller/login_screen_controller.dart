import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/authentication/model/login_info.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isFromValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Add listeners to validate form on every change
    emailController.addListener(validateForm);
    passwordControler.addListener(validateForm);
  }

  void validateForm() {
    isFromValid.value =
        emailController.text.isNotEmpty && passwordControler.text.isNotEmpty;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    EasyLoading.show(status: 'Logging in...');
    try {
      Map<String, dynamic> requestBody = {
        'email': emailController.text.trim(),
        'password': passwordControler.text.trim(),
      };

      final response = await http.post(
        Uri.parse(Urls.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      debugPrint("Response body: ${response.body}");
      debugPrint("Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final loginInfo = LoginInfo.fromJson(jsonDecode(response.body));

        if (loginInfo.approvalToken != null) {
          // Save tokens and user info as before
          await SharedPreferencesHelper.saveTokenAndRole(
            loginInfo.approvalToken ?? '',
          );

          EasyLoading.showSuccess(loginInfo.message ?? "Login Successful");

          await setFCMToken();
          // Check if OTP is verified
          // if (loginInfo.user?.otpVerified == false) {
          //   Get.to(
          //     () => LoginOtpSendScreen(),
          //     arguments: {
          //       'approvalToken': loginInfo.approvalToken ?? '',
          //       'email': emailController.text.trim(),
          //     },
          //   );
          //   sendCode();
          // } else
           if (loginInfo.meta?.isAboutMeGenerated == false) {
            Get.put(ProfileSetupController());
            Get.to(() => ProfileSetup());
          } else {
            Get.offAll(() => BottomNavbarView());
          }
        } else {
          EasyLoading.showError(
            loginInfo.message ?? "Login Failed - No approval token",
          );
        }
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          EasyLoading.showError(errorResponse['message'] ?? "Login Failed");
        } catch (e) {
          EasyLoading.showError(
            "Login Failed with status code: ${response.statusCode}",
          );
        }
      }
    } catch (e) {
      EasyLoading.showError("An error occurred during login");
      debugPrint("Login Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //===========================================================================================
  void sendCode() async {
    try {
      EasyLoading.show(status: 'Sending OTP...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? approvalToken = prefs.getString('approvalToken');
      if (approvalToken == null || approvalToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        return;
      }
      await prefs.remove('token');
      final response = await http.post(
        Uri.parse(Urls.sendOtp),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': approvalToken,
        },
        body: jsonEncode({}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response and extract the token
        var responseData = jsonDecode(response.body);
        var token = responseData['body']['token']; // Extract token

        // Save token to SharedPreferences
        if (token != null && token.isNotEmpty) {
          await prefs.setString('token', token);
        }
        EasyLoading.showSuccess('OTP Sent Successfully');
      } else {
        // Option 2: If 401 Unauthorized, try without Bearer prefix
        if (response.statusCode == 401) {
          final retryResponse = await http.post(
            Uri.parse(Urls.sendOtp),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': approvalToken,
            },
            body: jsonEncode({}),
          );
          if (retryResponse.statusCode == 200 ||
              retryResponse.statusCode == 201) {
            var retryResponseData = jsonDecode(retryResponse.body);
            var retryToken =
                retryResponseData['body']['token']; // Extract token

            // Save token to SharedPreferences
            if (retryToken != null && retryToken.isNotEmpty) {
              await prefs.setString('authToken', retryToken);
            }
            EasyLoading.showSuccess('OTP Sent Successfully');
            return;
          }
        }
        final bodyResponse = await http.post(
          Uri.parse(Urls.sendOtp),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'approvalToken': approvalToken}),
        );
        if (bodyResponse.statusCode == 200 || bodyResponse.statusCode == 201) {
          var bodyResponseData = jsonDecode(bodyResponse.body);
          var bodyToken = bodyResponseData['body']['token'];
          if (bodyToken != null && bodyToken.isNotEmpty) {
            await prefs.setString('authToken', bodyToken);
          }
          EasyLoading.showSuccess('OTP Sent Successfully');
          return;
        }
        var errorData = jsonDecode(response.body);
        EasyLoading.showError(errorData['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //===========================================================================================

  Future<void> setFCMToken() async {
  try {
    // First get the FCM token
    final fcmToken = await SharedPreferencesHelper.getFCMToken();
    if (fcmToken == null || fcmToken.isEmpty) {
      debugPrint('❌ FCM token not found or empty.');
      return;
    }

    // Then get the access token
    final accessToken = await SharedPreferencesHelper.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      debugPrint('❌ Access token not found or empty.');
      EasyLoading.showError('Session expired. Please log in again.');
      return;
    }

    final url = Uri.parse(
      Urls.fcmToken,
    );

    final body = {"fcmToken": fcmToken};

    debugPrint('🔑 Access token: $accessToken');
    debugPrint('📤 Sending FCM token to server...');
    debugPrint('📱 FCM Token: $fcmToken');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': accessToken,
      },
      body: jsonEncode(body),
    );

    debugPrint('🔽 Response status: ${response.statusCode}');
    debugPrint('📥 Response body: ${response.body}');

    if (response.statusCode == 200) {
      debugPrint('✅ Success: FCM token updated!');
      // Don't show success message here to avoid UI clutter
    } else if (response.statusCode == 401) {
      debugPrint('❌ Error 401: Unauthorized (invalid/expired token)');
      EasyLoading.showError('Session expired. Please log in again.');
    } else {
      debugPrint('❌ Error ${response.statusCode}: ${response.body}');
      // Don't show error message here as it might not be critical
    }
  } on http.ClientException catch (e) {
    debugPrint('❌ Network error: $e');
    // Don't show error message for network issues
  } on FormatException catch (e) {
    debugPrint('❌ JSON parsing error: $e');
  } catch (e) {
    debugPrint('❌ Unexpected error in setFCMToken(): $e');
  }
}

  //===========================================================================================

  void clearFields() {
    emailController.clear();
    passwordControler.clear();
  }
}
