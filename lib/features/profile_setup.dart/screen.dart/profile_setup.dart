import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/profile_setupcontroller.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_slider.dart';

// ignore: must_be_immutable
class ProfileSetup extends StatelessWidget {
  ProfileSetup({super.key});
  ProfileSetupController profileSetupcontroller = Get.put(ProfileSetupController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Obx(() {
                  // Get name from userInfo (or default "Nolan Saris" if name is null)
                  String name = homeScreenController.userInfo.value?.data?.name ?? "Rusell";
                  return Text(
                    "Welcome $name! \nLet's begin your journey to a successful interview",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImagePath.hellow1,
                    height: 233.755,
                    width: 229.059,
                  ),
                ),
                SizedBox(height: 36),

                // "Upload Your Resume" Text
                Text(
                  "Upload Your Resume",
                  style: TextStyle(
                    color: Color(0xff6a329f),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // SizedBox(height: 12),

                // File Picker Section
                // GestureDetector(
                //   onTap: () async {
                //     // Call the pickFile method from the controller
                //     await profileSetupcontroller.pickFile();
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: Color(0xff6a329f).withValues(alpha: 0.1),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: 16),
                //       child: Center(
                //         child: Column(
                //           children: [
                //             Image.asset(IconPath.backup, height: 32, width: 32),
                //             SizedBox(height: 8),
                //             Text(
                //               "Select File",
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w500,
                //                 color: Color(0xff212121),
                //               ),
                //             ),
                //             SizedBox(height: 8),
                //             Text(
                //               "Supported Formats: PDF, DOC, DOCX",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w400,
                //                 color: Color(0xff898989),
                //               ),
                //             ),
                //             // Display selected file name if available
                //             Obx(() {
                //               return Text(
                //                 profileSetupcontroller.selectedFileName.value.isEmpty
                //                     ? "No file selected"
                //                     : profileSetupcontroller.selectedFileName.value,
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w400,
                //                   color: Color(0xff212121),
                //                 ),
                //               );
                //             }),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                
                // SizedBox(height: 48),

                // Continue Button
                // ElevatedButton(
                //   onPressed: () {
                //     // Continue action
                //     profileSetupcontroller.uploadFile();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xff6a329f),
                //     minimumSize: Size(double.infinity, 48),
                //   ),
                //   child: Text(
                //     "Continue",
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                SizedBox(height: 16),

                // Enter Manually Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to ProfileSlider screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileSlider()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color(0xff6a329f)),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: Text(
                    "Enter Manually",
                    style: TextStyle(
                      color: Color(0xff6a329f),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
