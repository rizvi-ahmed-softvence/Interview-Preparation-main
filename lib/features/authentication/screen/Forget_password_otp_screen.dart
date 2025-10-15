// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/authentication/controller/forget_password_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPasswordOtpScreen extends StatelessWidget {
  ForgetPasswordOtpScreen({super.key});
  final controller = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final email = args['email'] ?? '';

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Enter the confirmation \n code',
                  style: getTextStyle(
                    color: const Color(0xFF082B09),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildPinCodeTextField(context),
                const SizedBox(height: 20),
                Text(
                  'Verification code has been sent to the email',
                  style: getTextStyle(
                    color: AppColors.textThird,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      email,
                      style: getTextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () => GestureDetector(
                    onTap: controller.resendEnabled.value
                        ? () => controller.forgetPassword()
                        : null,
                    child: Text(
                      controller.resendEnabled.value
                          ? "Resend Code"
                          : "Resend Code in ${controller.countdown.value}s",
                      style: getTextStyle(
                        color: AppColors.textThird,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Obx(
                  () => CustomButton1(
                    title: 'Continue',
                    backgroundColor: const Color(0xff6a329f),
                    textcolor: Colors.white,
                    borderColor: Colors.transparent,
                    onPress: controller.isFormValid.value
                        ? () => controller.forgetpasswordValidatepin(email)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 40,
        fieldWidth: 40,
        activeFillColor: AppColors.otpbg,
        selectedFillColor: AppColors.otpbg,
        inactiveFillColor: AppColors.otpbg,
        inactiveColor: AppColors.otpbg,
        selectedColor: AppColors.otpbg,
        activeColor: AppColors.otpbg,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      controller: controller.pinController,
      onCompleted: (v) => controller.validateForm(),
      onChanged: (value) => controller.validateForm(),
      appContext: context,
    );
  }
}