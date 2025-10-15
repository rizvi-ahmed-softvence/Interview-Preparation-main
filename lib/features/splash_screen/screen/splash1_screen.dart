import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/features/authentication/screen/signup_screen.dart';
import 'package:inprep_ai/features/splash_screen/widgets/custom_button.dart'; // Make sure AppColors is imported

class Splash1Screen1 extends StatelessWidget {
  const Splash1Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
         
          Positioned.fill(
            child: Image.asset(
              ImagePath.splash3,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  IconPath.splash1,
                  width: screenWidth,
                ),
                Column(
                  children: [
                    Text(
                      'Start Your Journey \n to Success!',
                      style: getTextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    
                    Text(
                      'Prepare confidently with personalized \n practice, instant feedback, and continuous \n improvement',
                      style: getTextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: "Sign Up",
                          fontSize: 16,
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.07,
                          buttonColor: Colors.transparent,
                          isBorder: true,
                          onTap: () {
                            Get.to(SignupScreen());
                          },
                        ),
                        SizedBox(width: 20),
                        CustomButton(
                          text: "login",
                          fontSize: 16,
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.07,
                          buttonColor: AppColors.buttonColor,
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
