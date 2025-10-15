import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/auhe_custom_textfiled.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/authentication/controller/forget_password_controller.dart';
import 'package:inprep_ai/features/authentication/widget/custom_send_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 65),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Forget Password",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff333333),
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  "Please Enter your email address for confirmation code.",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF5F5F5F),
                  ),
                ),
                const SizedBox(height: 18),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (controller.toggleValue.value != 0) {
                        controller.toggle();
                      }
                    },
                    child: Container(
                      width: 84,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            controller.toggleValue.value == 0
                                ? const Color(0xFF3A4C67)
                                : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            "Email",
                            style: getTextStyle(
                              color:
                                  controller.toggleValue.value == 0
                                      ? Colors.white
                                      : const Color(0xFF3A4C67),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Obx(
                    () => Text(
                      controller.toggleValue.value == 0 ? "Email" : "Phone",
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => AuthCustomTextField(
                    controller:
                        controller.toggleValue.value == 0
                            ? controller.emailController
                            : controller.phoneController,
                    text:
                        controller.toggleValue.value == 0
                            ? "Enter your Email"
                            : "Enter your phone number",
                  ),
                ),
                const SizedBox(height: 60),
                CustomSendButton(
                  onPressed: () {
                    final email = controller.emailController.text.trim();
                    if (email.isNotEmpty && GetUtils.isEmail(email)) {
                      controller.forgetPassword();
                    } else {
                      EasyLoading.showError("Please enter a valid email");
                    }
                  },
                  text: "Send",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
