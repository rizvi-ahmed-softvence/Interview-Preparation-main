import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPController extends GetxController {
  // OTP related controllers
  TextEditingController pinController = TextEditingController();

  // Track OTP form validity
  var isFormValid = false.obs;

  // Countdown timer related variables
  var resendEnabled = true.obs;
  var countdown = 120.obs; // Time in seconds for the countdown
  Timer? timer; // Timer instance

  // Validate if the OTP form is filled correctly
  void validateForm() {
    isFormValid.value = pinController.text.length == 6;
  }

  var errorColor = false.obs;

  //====================================================================================
  void validatePin(String? email) async {
    debugPrint("Parsing email: $email");

    try {
      EasyLoading.show(status: 'Verifying OTP...');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('token');

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError("Session expired. Please login again.");
        return;
      }

      String otp = pinController.text.trim();
      debugPrint("User input OTP: $otp");

      if (otp.isEmpty) {
        EasyLoading.showError("Please enter a valid OTP.");
        return;
      }

      final response = await http.post(
        Uri.parse(Urls.verifyOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "token": accessToken,
          "recivedOTP": otp, // or "code": otp, depending on backend
        }),
      );

      debugPrint('Response Body: ${response.body}');
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('OTP Verified Successfully, navigating...');
        EasyLoading.showSuccess('OTP Verified Successfully');
        pinController.clear(); // Clear OTP input field here
        Get.to(() => LoginScreen());
      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['message'] ?? 'An error occurred';
        if (errorMessage.contains('Invalid or expired OTP')) {
          errorColor.value = true;
          EasyLoading.showError("Invalid or expired OTP. Please try again.");
        } else {
          EasyLoading.showError(errorMessage);
        }
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  //====================================================================================
  void loginValidatepin(String? email) async {
    debugPrint("Parsing email: $email");

    try {
      EasyLoading.show(status: 'Verifying OTP...');
      debugPrint("EasyLoading started with status 'Verifying OTP...'");

      // Retrieve the access token using SharedPreferencesHelper
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('token');

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError("Session expired. Please login again.");
        return;
      }

      String otp = pinController.text.trim();
      debugPrint("User input OTP: $otp");

      if (otp.isEmpty) {
        EasyLoading.showError("Please enter a valid OTP.");
        debugPrint("OTP is empty, showing error 'Please enter a valid OTP.'");
        return;
      }

      debugPrint(
        'Sending OTP verification request with token: $accessToken and OTP: $otp',
      );

      final response = await http.post(
        Uri.parse(Urls.verifyOtp),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken, // Use Bearer token here
        },
        body: jsonEncode({
          "token": accessToken,
          "recivedOTP": otp, // Only send OTP in body
        }),
      );

      debugPrint('Response Body: ${response.body}');
      debugPrint("Status Code: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint('OTP Verified Successfully, navigating...');
        EasyLoading.showSuccess('OTP Verified Successfully');
        pinController.clear(); // Clear OTP input field here
        debugPrint(
          "OTP Verified Successfully, clearing OTP field and navigating.",
        );
        Get.to(() => BottomNavbarView());
      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['message'] ?? 'An error occurred';
        debugPrint("Error message from response: $errorMessage");

        if (errorMessage.contains('Invalid or expired OTP')) {
          errorColor.value = true;
          EasyLoading.showError("Invalid or expired OTP. Please try again.");
          debugPrint(
            "Invalid or expired OTP, showing error 'Invalid or expired OTP. Please try again.'",
          );
        } else if (errorMessage.contains('Invalid token data')) {
          EasyLoading.showError("Invalid session token. Please login again.");
          debugPrint(
            "Invalid session token, showing error 'Invalid session token. Please login again.'",
          );
        } else {
          EasyLoading.showError(errorMessage);
          debugPrint("Generic error, showing error message: $errorMessage");
        }
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
      debugPrint("Exception caught: $e");
    } finally {
      EasyLoading.dismiss();
      debugPrint("EasyLoading dismissed.");
    }
  }

  void resendCode() async {
    debugPrint("Entered resendCode function.");
    try {
      EasyLoading.show(status: 'Sending OTP...');
      debugPrint("EasyLoading status shown: Sending OTP...");

       SharedPreferences prefs = await SharedPreferences.getInstance();
      debugPrint("SharedPreferences instance obtained.");

      String? accessToken = prefs.getString('token');
      debugPrint("Access token retrieved: $accessToken");

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError("Access token is missing. Please login again.");
        debugPrint("Access token is null or empty.");
        return;
      }

      Map<String, String> requestBody = {"resendOTPtoken": accessToken};
      debugPrint("Request body prepared: $requestBody");

      final response = await http.post(
        Uri.parse(Urls.resendOtp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      debugPrint("HTTP POST request sent to ${Urls.resendOtp}");
      debugPrint("Response received.");
      debugPrint("Response Body: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");

      if (response.body.isEmpty) {
        debugPrint("Response body is empty.");
        EasyLoading.showError("Received an empty response. Please try again.");
        return;
      }

      try {
        var responseData = jsonDecode(response.body);
        debugPrint("Parsed response data: $responseData");

        if (response.statusCode == 200 || response.statusCode == 201) {
          EasyLoading.showSuccess('OTP Sent Successfully');
          debugPrint('OTP Sent Successfully: ${response.body}');
          startCountdown();
          debugPrint("Countdown started.");
        } else {
          var errorMessage = responseData['message'] ?? 'An error occurred';
          debugPrint("Error Message extracted: $errorMessage");

          if (errorMessage.contains('Invalid or expired OTP')) {
            EasyLoading.showError("Invalid or expired OTP. Please try again.");
            debugPrint("Displayed error: Invalid or expired OTP");
          } else {
            EasyLoading.showError(errorMessage);
            debugPrint("Displayed error: $errorMessage");
          }
        }
      } catch (e) {
        debugPrint("Error decoding response: $e");
        EasyLoading.showError("Error decoding response. Please try again.");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong: $e");
      debugPrint("Error occurred in resendCode try block: $e");
    } finally {
      EasyLoading.dismiss();
      debugPrint("EasyLoading dismissed.");
      debugPrint("OTP process finished.");
    }
    debugPrint("Exiting resendCode function.");
  }

  // Start the countdown when the OTP is sent
  void startCountdown() {
    resendEnabled.value = false; // Disable the button
    countdown.value = 120; // Reset the countdown to 120 seconds

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        resendEnabled.value = true; // Enable the button after the countdown
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }
}
