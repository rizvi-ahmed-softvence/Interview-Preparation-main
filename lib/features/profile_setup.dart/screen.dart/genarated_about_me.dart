
// // ignore_for_file: unused_element

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';
// import 'package:inprep_ai/core/utils/constants/colors.dart';
// import 'package:inprep_ai/features/profile_setup.dart/controller/genarated_about_me_controller.dart';
// import 'package:inprep_ai/features/profile_setup.dart/models/generate_about_me.dart';
// import 'package:inprep_ai/features/profile_setup.dart/models/update_resume.dart';
// import 'package:inprep_ai/features/profile_setup.dart/screen.dart/record_screen.dart';

// class GenaratedAboutMe extends StatelessWidget {
//   GenaratedAboutMe({super.key});

//   final GenaratedAboutMeController genaratedAboutMeController = Get.put(
//     GenaratedAboutMeController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     // Get the passed arguments
//     final Generateaboutme? generateaboutme = Get.arguments is Generateaboutme ? Get.arguments : null;
//     final Updateresume? updateresume = Get.arguments is Updateresume ? Get.arguments : null;

//     // Determine which content to display
//     String aboutMeContent = "No AI-generated content available.";
//     if (generateaboutme?.profile?.generatedAboutMe != null && updateresume?.aboutMe?.generatedAboutMe != null) {
//       // Both are available, combine with a separator
//       aboutMeContent = "${generateaboutme!.profile!.generatedAboutMe}\n\n--- Updated Resume ---\n\n${updateresume!.aboutMe!.generatedAboutMe}";
//     } else if (generateaboutme?.profile?.generatedAboutMe != null) {
//       // Only Generateaboutme is available
//       aboutMeContent = generateaboutme!.profile!.generatedAboutMe!;
//     } else if (updateresume?.aboutMe?.generatedAboutMe != null) {
//       // Only Updateresume is available
//       aboutMeContent = updateresume!.aboutMe!.generatedAboutMe!;
//     }

//     // Set the text in the TextEditingController
//     genaratedAboutMeController.aboutme.text = aboutMeContent;

//     // Calculate the number of lines required to display the content in the TextField
//     int maxLines = _calculateMaxLines(aboutMeContent);

//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.primaryColor,
//         centerTitle: true,
//         title: Text(
//           "About Me AI Generated",
//           style: getTextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: const Color(0xff212121),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextField(
//                 scrollPhysics: const NeverScrollableScrollPhysics(),
//                 maxLines: maxLines,
//                 readOnly: true,
//                 controller: genaratedAboutMeController.aboutme,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   labelText: 'AI Generated About Me',
//                   hintText: 'Your AI generated about me will appear here',
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide: const BorderSide(color: Color(0xff6a329f)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide: const BorderSide(color: Color(0xff6a329f)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Display additional data from Updateresume (e.g., technical skills, education, experience)
//               // if (updateresume?.data != null) ...[
//               //   const SizedBox(height: 20),
//               //   Text(
//               //     "Updated Resume Details",
//               //     style: getTextStyle(
//               //       fontSize: 20,
//               //       fontWeight: FontWeight.w600,
//               //       color: const Color(0xff212121),
//               //     ),
//               //   ),
//               //   const SizedBox(height: 10),
//               //   if (updateresume!.data!.technicalSkills != null &&
//               //       updateresume.data!.technicalSkills!.isNotEmpty)
//               //     _buildSection(
//               //       title: "Technical Skills",
//               //       content: updateresume.data!.technicalSkills!.join(", "),
//               //     ),
//               //   if (updateresume.data!.education != null &&
//               //       updateresume.data!.education!.isNotEmpty)
//               //     _buildSection(
//               //       title: "Education",
//               //       content: updateresume.data!.education!
//               //           .map((e) =>
//               //               "${e.degree} at ${e.institution} (${e.completionDate})")
//               //           .join("\n"),
//               //     ),
//               //   if (updateresume.data!.experience != null &&
//               //       updateresume.data!.experience!.isNotEmpty)
//               //     _buildSection(
//               //       title: "Experience",
//               //       content: updateresume.data!.experience!
//               //           .map((e) =>
//               //               "${e.jobTitle} at ${e.compnay} (${e.startDate} - ${e.endDate})")
//               //           .join("\n"),
//               //     ),
//               // ],
//               // // Display additional data from Generateaboutme (if applicable)
//               // if (generateaboutme?.data != null) ...[
//               //   const SizedBox(height: 20),
//               //   Text(
//               //     "Resume Details",
//               //     style: getTextStyle(
//               //       fontSize: 20,
//               //       fontWeight: FontWeight.w600,
//               //       color: const Color(0xff212121),
//               //     ),
//               //   ),
//               //   const SizedBox(height: 10),
//               //   if (generateaboutme!.data!.technicalSkills != null &&
//               //       generateaboutme.data!.technicalSkills!.isNotEmpty)
//               //     _buildSection(
//               //       title: "Technical Skills",
//               //       content: generateaboutme.data!.technicalSkills!.join(", "),
//               //     ),
//               //   if (generateaboutme.data!.education != null &&
//               //       generateaboutme.data!.education!.isNotEmpty)
//               //     _buildSection(
//               //       title: "Education",
//               //       content: generateaboutme.data!.education!
//               //           .map((e) =>
//               //               "${e.degree} at ${e.institution} (${e.completionDate})")
//               //           .join("\n"),
//               //     ),
//               // ],
//               // const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   // Navigate to video recording screen and wait for result
//                   final videoPath = await Get.to(() => VideoRecordingScreen());
//                   if (videoPath != null) {
//                     debugPrint("Video recorded and saved at: $videoPath");
//                     Get.snackbar(
//                       'Success',
//                       'Video recorded successfully at: $videoPath',
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff6a329f),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: const Text(
//                   "Take Interview",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper widget to build sections for displaying additional data
//   Widget _buildSection({required String title, required String content}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: getTextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xff212121),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             border: Border.all(color: const Color(0xff6a329f)),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(
//             content,
//             style: const TextStyle(fontSize: 14),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }

//   // Calculate the number of lines based on the content and text field width
//   int _calculateMaxLines(String text) {
//     final TextPainter textPainter = TextPainter(
//       text: TextSpan(text: text, style: const TextStyle(fontSize: 16)),
//       maxLines: 1000,
//       textDirection: TextDirection.ltr,
//     );

//     // Layout the text and determine the height
//     textPainter.layout(maxWidth: Get.width - 40); // Account for padding

//     // Calculate the number of lines
//     int lines = (textPainter.size.height / 24).ceil(); // Estimate for line height
//     return lines > 0 ? lines : 1; // Ensure at least 1 line
//   }
// }


// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/genarated_about_me_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/generate_about_me.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/update_resume.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/record_screen.dart';

class GenaratedAboutMe extends StatelessWidget {
  GenaratedAboutMe({super.key});

  final GenaratedAboutMeController genaratedAboutMeController = Get.put(
    GenaratedAboutMeController(),
  );

  @override
  Widget build(BuildContext context) {
    // Show the dialog when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show the dialog with the message and OK button
      Get.dialog(
        AlertDialog(
          backgroundColor: Colors.white, // Set the dialog background color to white
          title: Text('Interview Tip',
            style: getTextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xff212121),
            ),
          ),
          content: Text(
            "In 90% of interviews, the first question is “Please tell us about yourself”. While this seems simple, it is very difficult to pack years of life and experience information in 2 minutes time.\n\nAt Inprep, we have used our AI to generate a perfect response for you.",
            style: getTextStyle(
             fontWeight: FontWeight.w500,
              color: const Color(0xff212121),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Dismiss the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
        barrierDismissible: false, // Prevent closing the dialog by tapping outside
      );
    });

    // Get the passed arguments
    final Generateaboutme? generateaboutme = Get.arguments is Generateaboutme ? Get.arguments : null;
    final Updateresume? updateresume = Get.arguments is Updateresume ? Get.arguments : null;

    // Determine which content to display
    String aboutMeContent = "No AI-generated content available.";
    if (generateaboutme?.profile?.generatedAboutMe != null && updateresume?.aboutMe?.generatedAboutMe != null) {
      // Both are available, combine with a separator
      aboutMeContent = "${generateaboutme!.profile!.generatedAboutMe}\n\n--- Updated Resume ---\n\n${updateresume!.aboutMe!.generatedAboutMe}";
    } else if (generateaboutme?.profile?.generatedAboutMe != null) {
      // Only Generateaboutme is available
      aboutMeContent = generateaboutme!.profile!.generatedAboutMe!;
    } else if (updateresume?.aboutMe?.generatedAboutMe != null) {
      // Only Updateresume is available
      aboutMeContent = updateresume!.aboutMe!.generatedAboutMe!;
    }

    // Set the text in the TextEditingController
    genaratedAboutMeController.aboutme.text = aboutMeContent;

    // Calculate the number of lines required to display the content in the TextField
    int maxLines = _calculateMaxLines(aboutMeContent);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "About Me AI Generated",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xff212121),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextField with black text color
              TextField(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                maxLines: maxLines,
                readOnly: true,
                controller: genaratedAboutMeController.aboutme,
                style: TextStyle(
                  color: Colors.black
                ), // Set text color to black
                decoration: InputDecoration(
                  labelText: 'AI Generated About Me', // The label text
                  labelStyle: TextStyle(
                    color: Colors.black, // Set label text color to black
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Your AI generated about me will appear here',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xff6a329f)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xff6a329f)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to video recording screen and wait for result
                  final videoPath = await Get.to(() => VideoRecordingScreen());
                  if (videoPath != null) {
                    debugPrint("Video recorded and saved at: $videoPath");
                    Get.snackbar(
                      'Success',
                      'Video recorded successfully at: $videoPath',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6a329f),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Take Interview",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build sections for displaying additional data
  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff212121),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff6a329f)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Calculate the number of lines based on the content and text field width
  int _calculateMaxLines(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16)),
      maxLines: 1000,
      textDirection: TextDirection.ltr,
    );

    // Layout the text and determine the height
    textPainter.layout(maxWidth: Get.width - 40); // Account for padding

    // Calculate the number of lines
    int lines = (textPainter.size.height / 24).ceil(); // Estimate for line height
    return lines > 0 ? lines : 1; // Ensure at least 1 line
  }
}
