// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/authentication/controller/login_screen_controller.dart';
import 'package:inprep_ai/features/authentication/screen/forget_password_screen.dart'
    show ForgetPasswordScreen;
import 'package:inprep_ai/routes/app_routes.dart';
import '../../../core/common/styles/global_text_style.dart';
import '../../../core/common/widgets/auhe_custom_textfiled.dart'
    show AuthCustomTextField;
import '../../../core/common/widgets/custom_contain_button.dart'
    show CustomContinueButton;

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginScreenController loginController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Log In',
          style: getTextStyle(
            color: Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AuthCustomTextField(
                  onChanged: (value) {
                    loginController.validateForm();
                  },
                  controller: loginController.emailController,
                  text: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Incorrect email or password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Obx(() {
                  return AuthCustomTextField(
                    onChanged: (value) {
                      loginController.validateForm();
                    },
                    text: 'Enter your password',
                    controller: loginController.passwordControler,
                    obscureText: loginController.isPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect email or password';
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(height: 32),
                Obx(() => CustomContinueButton(
                      onTap: () {
                        loginController.login();
                      },
                      title: "Log In",
                      textColor: loginController.isFromValid.value
                          ? Colors.white
                          : Color(0xff6a329f),
                      backgroundColor: loginController.isFromValid.value
                          ? Color(0xff6a329f)
                          : Color(0xFFEBF8F1),
                    )),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: getTextStyle(
                        color: Color(0xFF3A4C67),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 36),
                SizedBox(height: 32),
                if (Platform.isAndroid || Platform.isIOS) ...[
                  // Google sign-in UI here (commented out)
                ],
                SizedBox(height: 16),
                if (Platform.isIOS) ...[
                  // Apple sign-in UI here (commented out)
                ],
                SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: getTextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.signupScreen);
                      },
                      child: Text(
                        "Sign Up",
                        style: getTextStyle(
                          color: Color(0xff6a329f),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
