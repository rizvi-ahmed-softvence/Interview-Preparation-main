import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../controller/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  final OTPController otpController = Get.put(OTPController());

  OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments ?? '';

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Enter the confirmation \n code',
                  style: getTextStyle(
                    color: Color(0xFF082B09),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                _buildPinCodeTextField(context),
                SizedBox(height: 20),
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
                      'Your $email',
                      style: getTextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(
                  () => GestureDetector(
                    onTap:
                        otpController.resendEnabled.value
                            ? () {
                              otpController.resendCode();
                            }
                            : null,
                    child: Text(
                      otpController.resendEnabled.value
                          ? "Resend Code"
                          : "Resend Code in ${otpController.countdown.value}s",
                      style: getTextStyle(
                        color: AppColors.textThird,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Obx(
                  () => CustomButton1(
                    title: 'Continue',
                    backgroundColor: Color(0xff6a329f),
                    textcolor: Color(0xffffffff),
                    borderColor: Colors.transparent,

                    onPress:
                        otpController.isFormValid.value
                            ? () {
                              otpController.validatePin(email);
                            }
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

  // Widget _buildPinCodeTextField(BuildContext context) {
  //   return PinCodeTextField(
  //     length: 6,
  //     obscureText: false,
  //     keyboardType: TextInputType.number,
  //     pinTheme: PinTheme(
  //       shape: PinCodeFieldShape.box,
  //       borderRadius: BorderRadius.circular(8),
  //       fieldHeight: 40,
  //       fieldWidth: 40,
  //       activeFillColor: AppColors.otpbg,
  //       selectedFillColor: AppColors.otpbg,
  //       inactiveFillColor: AppColors.otpbg,
  //       inactiveColor: AppColors.otpbg,
  //       selectedColor: AppColors.otpbg,
  //       activeColor: AppColors.otpbg,
  //     ),
  //     animationDuration: const Duration(milliseconds: 300),
  //     backgroundColor: Colors.transparent,
  //     controller: otpController.pinController,
  //     appContext: context,
  //     onChanged: (value) {
  //       otpController.validateForm();
  //     },
  //   );
  // }
  Widget _buildPinCodeTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
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
      controller: otpController.pinController,
      appContext: context,
      onChanged: (value) {
        otpController.validateForm();
      },
      // Set text style to modify text input color and other properties
      textStyle: TextStyle(
        color: Colors.black, // Set the text color to black
      ),
    );
  }
}
