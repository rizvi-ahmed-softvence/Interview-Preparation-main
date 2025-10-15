import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/routes/app_routes.dart';
import '../../../core/common/widgets/auhe_custom_textfiled.dart'
    show AuthCustomTextField;
import '../../../core/common/widgets/custom_button.dart';
import '../controller/signup_screen_controller.dart' show SignupController;

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final SignupController singupController = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Text(
          'Sign Up',
          style: getTextStyle(
            color: const Color(0xFF333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  'Name',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  text: 'Enter your Name',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  controller: singupController.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Phone Number',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller: singupController.phoneController1,
                  text: 'Enter your Phone Number',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  // Removed validator here
                  validator: null,
                ),
                const SizedBox(height: 16),
                Text(
                  'Email',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                AuthCustomTextField(
                  controller: singupController.emailController1,
                  text: 'Enter your Email',
                  onChanged: (value) {
                    singupController.validateFrom();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid email address';
                    }
                    RegExp emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Invalid email format. Example: example@mail.com';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Password',
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => AuthCustomTextField(
                    text: 'Enter your Password',
                    onChanged: (value) {
                      singupController.validateFrom();
                    },
                    controller: singupController.passwordController,
                    obscureText: singupController.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        singupController.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xff6a329f),
                      ),
                      onPressed: singupController.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Retype Password',
                  style: getTextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(
                  () => AuthCustomTextField(
                    controller: singupController.retypepasswordController,
                    text: 'Enter your Password',
                    onChanged: (value) {
                      singupController.validateFrom();
                    },
                    obscureText: singupController.isPasswordVisible1.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        singupController.isPasswordVisible1.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: const Color(0xff6a329f),
                      ),
                      onPressed: singupController.togglePasswordVisibility1,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != singupController.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: Text(
                          'I agree to the terms of service and privacy policy',
                          style: getTextStyle(color: Colors.black),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: Checkbox(
                          value: singupController.isTermsAccepted.value,
                          onChanged: (_) {
                            singupController
                                .toggleTermsAcceptance(); // Call this to update state
                          },
                          activeColor: Color(0xff6a329f),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Obx(
                  () => CustomButton1(
                    title: 'Sign Up',
                    textcolor:
                        singupController.isFromValid.value
                            ? Colors.white
                            : const Color(0xff6a329f),
                    onPress:
                        singupController.isFromValid.value
                            ? () {
                              if (_formKey.currentState!.validate()) {
                                singupController.signup();
                              }
                            }
                            : null,
                    backgroundColor:
                        singupController.isFromValid.value
                            ? const Color(0xff6a329f)
                            : const Color(0xFFEBF8F1),
                    borderColor:
                        singupController.isFromValid.value
                            ? const Color(0xff6a329f)
                            : const Color(0xFFEBF8F1),
                  ),
                ),

                const SizedBox(height: 28),
                const SizedBox(height: 32),
                if (Platform.isAndroid || Platform.isIOS) ...[],
                const SizedBox(height: 16),
                if (Platform.isIOS) ...[],
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: getTextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.loginScreen);
                      },
                      child: Text(
                        "Sign In",
                        style: getTextStyle(
                          color: const Color(0xff6a329f),
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
