import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart' show IconPath;
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart' show ProfileSetupController;
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_slider.dart' show ProfileSlider;
import 'package:inprep_ai/features/splash_screen/widgets/custom_button.dart';

class UploadResumeScreen extends StatelessWidget {
   UploadResumeScreen({super.key});

  final ProfileSetupController controller = Get.put(ProfileSetupController()); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: 65, 
          left: 16, 
          right: 16, 
          bottom: 15
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello Rassen!\nWelcome",
                style: getTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff212121),
                ),
              ),
              SizedBox(
                height: 16,
              ), 
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImagePath.hellow1,
                  height: 266,
                  width: 266,
                ),
              ),
              SizedBox(
                height: 20,
              ), 
              Text("Upload Your Resume",
                style: getTextStyle(
                  color: Color(0xff37BB74),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.pickFile();
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFEBF8F1), 
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(
                            IconPath.backup,
                            height: 32,
                            width: 32,
                          ), 
                          SizedBox(
                            height: 8,
                          ),
                          Text("Select File",
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff212121),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Supported Formats: PDF",
                            style: getTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff898989),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ), 
              SizedBox(
                height: 20,
              ),
               Obx(() {
                // Display the selected file name or a placeholder message
                return Text(
                  "Selected File: ${controller.selectedFileName.value}",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff212121),
                  ),
                );
              }),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: (){
                  Get.offAll(BottomNavbarView());
                },
                buttonColor: Color(0xff37BB74),
                textColor: Colors.white,
                isBorder: false,
                fontSize: 16,
                text: "Continue", 
                width: double.infinity, 
                height: 48,
              ), 
              SizedBox(
                height: 20,
              ), 
              CustomButton(
                onTap: (){
                  Get.to(ProfileSlider()); 
                },
                buttonColor: Colors.transparent,
                textColor: Color(0xff6a329f),
                borderColor: Color(0xff6a329f),
                isBorder: true,
                fontSize: 16,
                text: "Enter Manually", 
                width: double.infinity, 
                height: 48,
              ), 
            ],
          ),
        ),
      ),
    );
  }
}