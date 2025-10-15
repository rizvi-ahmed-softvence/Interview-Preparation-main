import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import '../../../core/common/styles/global_text_style.dart' show getTextStyle;
import '../../../core/common/widgets/auhe_custom_textfiled.dart'
    show AuthCustomTextField;

import '../controller/change_password_controller.dart'
    show ChangePasswordController;

class ChangePassword extends StatelessWidget {
  final String? email;
  const ChangePassword({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.put(
      ChangePasswordController(),
    );
    
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'Change Password',
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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
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
                  controller: controller.newPasswordEditingController,
                  text: 'Enter your Password',
                  obscureText: true,
                  onChanged: (value) {
                    controller.newPasswordError.value = '';
                  },
                  validator: (value) {
                    if (controller.newPasswordError.value.isNotEmpty) {
                      return controller.newPasswordError.value;
                    }
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
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
                      'Confirm Password',
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
                  controller: controller.confirmPasswordEditingController,
                  text: 'Confirm your Password',
                  obscureText: true,
                  onChanged: (value) {
                    controller.confirmPasswordError.value = '';
                  },
                  validator: (value) {
                    if (controller.confirmPasswordError.value.isNotEmpty) {
                      return controller.confirmPasswordError.value;
                    }
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.newPasswordEditingController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 44.0),
                CustomButton1(
                  title: 'Change',
                  textcolor: Colors.white,
                  backgroundColor: Color(0xff6a329f),
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      // Only pass email if it's not null
                      if (email != null) {
                        controller.changePassword(email!);
                      } else {
                        controller.changePassword();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}