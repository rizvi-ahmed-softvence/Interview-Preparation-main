// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/core/urls/endpint.dart';
// import 'package:inprep_ai/routes/app_routes.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SignupController extends GetxController {
//   // Declare the controllers for text fields
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController1 = TextEditingController();
//   TextEditingController emailController1 = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController retypepasswordController = TextEditingController();

//   var isPasswordVisible = false.obs;
//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   var isPasswordVisible1 = false.obs;
//   void togglePasswordVisibility1() {
//     isPasswordVisible1.value = !isPasswordVisible1.value;
//   }

//   var isFromValid = false.obs;
//   void validateFrom() {
//     bool nameValid = nameController.text.isNotEmpty;
//     bool phoneValid = RegExp(
//       r'^\+8801[3-9][0-9]{8}$',
//     ).hasMatch(phoneController1.text);
//     bool emailValid = RegExp(
//       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//     ).hasMatch(emailController1.text);
//     bool passwordValid = passwordController.text.length >= 8;
//     bool passwordsMatch =
//         passwordController.text == retypepasswordController.text;

//     isFromValid.value =
//         nameValid &&
//         phoneValid &&
//         emailValid &&
//         passwordValid &&
//         passwordsMatch;
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     phoneController1.dispose();
//     emailController1.dispose();
//     passwordController.dispose();
//     retypepasswordController.dispose();
//     super.onClose();
//   }

//   Future<void> signup() async {
//     debugPrint('[1] Starting signup process');
//     EasyLoading.show(status: 'Signing up...');

//     try {
//       debugPrint('[2] Preparing request body');
//       Map<String, dynamic> requestBody = {
//         'name': nameController.text.trim(),
//         'phone': phoneController1.text.trim(),
//         'email': emailController1.text.trim(),
//         'password': passwordController.text.trim(),
//         'confirmPassword': retypepasswordController.text.trim(),
//         'aggriedToTerms': "true",
//       };
//       debugPrint('[3] Request body: $requestBody');

//       debugPrint('[4] Making HTTP POST request to ${Urls.register}');
//       final response = await http.post(
//         Uri.parse(Urls.register),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestBody),
//       );
//       debugPrint(
//         '[5] Received response with status code: ${response.statusCode}',
//       );
//       debugPrint('[6] Response body: ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint('[7] Registration successful, parsing response');
//         final responseData = jsonDecode(response.body);
//         debugPrint('[8] Parsed response data: $responseData');

//         debugPrint('[9] Attempting to save access token');
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         String? token = responseData["token"] ?? responseData["data"]?["token"];
//         debugPrint('[10] Token to save: $token');

//         if (token != null) {
//           await prefs.setString('token', token);
//           debugPrint('[11] Token saved successfully');
//         } else {
//           debugPrint('[11] WARNING: No token received in response');
//         }
//         Get.offNamed(AppRoute.otpSentScreen, arguments: emailController1.text);

//         // Clear all controllers after successful signup
//         nameController.clear();
//         phoneController1.clear();
//         emailController1.clear();
//         passwordController.clear();
//         retypepasswordController.clear();
//         debugPrint('[12] All text controllers cleared');

//         debugPrint('[13] Attempting navigation to OTP screen');
//         debugPrint('[14] Route name: ${AppRoute.otpSentScreen}');
//         debugPrint('[15] Email argument: ${emailController1.text}');

//         debugPrint('[16] Navigation successful');

//         EasyLoading.showSuccess("Registration Successful");
//       } else {
//         debugPrint(
//           '[7] Registration failed with status ${response.statusCode}',
//         );
//         final responseData = jsonDecode(response.body);
//         String errorMessage = responseData["message"] ?? "Registration failed";
//         debugPrint('[8] Error message: $errorMessage');
//         EasyLoading.showError(errorMessage);
//       }
//     } catch (e, stackTrace) {
//       debugPrint('[ERROR] Exception caught in signup: $e');
//       debugPrint('[STACKTRACE] $stackTrace');
//       EasyLoading.showError("An error occurred: ${e.toString()}");
//     } finally {
//       debugPrint('[FINALLY] Dismissing loading indicator');
//       EasyLoading.dismiss();
//     }
//   }
// }

//==========================================================================
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  // Declare the controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypepasswordController = TextEditingController();
  var isTermsAccepted = false.obs;

  var isPasswordVisible = false.obs;
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleTermsAcceptance() {
    isTermsAccepted.toggle(); // Toggle the checkbox
    validateFrom(); // Revalidate the form whenever the checkbox state changes
  }

  var isPasswordVisible1 = false.obs;
  void togglePasswordVisibility1() {
    isPasswordVisible1.value = !isPasswordVisible1.value;
  }

  var isFromValid = false.obs;
  void validateFrom() {
    bool nameValid = nameController.text.isNotEmpty;
    bool emailValid = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(emailController1.text);
    bool passwordValid = passwordController.text.length >= 8;
    bool passwordsMatch =
        passwordController.text == retypepasswordController.text;
    bool termsAccepted = isTermsAccepted.value;

    // Update isFromValid based on all the validation checks
    isFromValid.value =
        nameValid &&
        emailValid &&
        passwordValid &&
        passwordsMatch &&
        termsAccepted;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController1.dispose();
    emailController1.dispose();
    passwordController.dispose();
    retypepasswordController.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    debugPrint('[1] Starting signup process');
    EasyLoading.show(status: 'Signing up...');

    try {
      debugPrint('[2] Preparing request body');
      Map<String, dynamic> requestBody = {
        'name': nameController.text.trim(),
        'phone': phoneController1.text.trim(),
        'email': emailController1.text.trim(),
        'password': passwordController.text.trim(),
        'confirmPassword': retypepasswordController.text.trim(),
        'aggriedToTerms': "true",
      };
      debugPrint('[3] Request body: $requestBody');

      debugPrint('[4] Making HTTP POST request to ${Urls.register}');
      final response = await http.post(
        Uri.parse(Urls.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      debugPrint(
        '[5] Received response with status code: ${response.statusCode}',
      );
      debugPrint('[6] Response body: ${response.body}');

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        debugPrint('[7] Registration response received, parsing data');
        final responseData = jsonDecode(response.body);
        debugPrint('[8] Parsed response data: $responseData');

        // Check for 'success' inside the response body
        bool success = responseData["data"]?["success"] ?? false;

        if (success) {
          // Registration successful, process token and navigate to OTP screen
          debugPrint('[9] Registration successful, processing token');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = responseData["data"]?["token"];
          debugPrint('[10] Token to save: $token');

          if (token != null) {
            await prefs.setString('token', token);
            debugPrint('[11] Token saved successfully');
          } else {
            debugPrint('[11] WARNING: No token received in response');
          }

          // Navigate to OTP screen
          // Get.offNamed(
          //   AppRoute.otpSentScreen,
          //   arguments: emailController1.text,
          // );
          Get.to(LoginScreen());

          // Clear all controllers after successful signup
          nameController.clear();
          phoneController1.clear();
          emailController1.clear();
          passwordController.clear();
          retypepasswordController.clear();
          debugPrint('[12] All text controllers cleared');

          EasyLoading.showSuccess("Registration Successful");
        } else {
          // If success is false, show the error message and navigate to the login screen
          String errorMessage =
              responseData["message"] ?? "Registration failed";
          debugPrint('[8] Error message: $errorMessage');
          EasyLoading.showError(errorMessage);

          // Navigate to the login screen if user already exists
          Get.offNamed(AppRoute.loginScreen);
        }
      } else {
        // Handle other unexpected status codes
        debugPrint(
          '[7] Registration failed with status ${response.statusCode}',
        );
        final responseData = jsonDecode(response.body);
        String errorMessage = responseData["message"] ?? "Registration failed";
        debugPrint('[8] Error message: $errorMessage');
        EasyLoading.showError(errorMessage);
      }
    } catch (e, stackTrace) {
      debugPrint('[ERROR] Exception caught in signup: $e');
      debugPrint('[STACKTRACE] $stackTrace');
      EasyLoading.showError("An error occurred: ${e.toString()}");
    } finally {
      debugPrint('[FINALLY] Dismissing loading indicator');
      EasyLoading.dismiss();
    }
  }
}

//==========================================================================
