// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';
// import 'package:inprep_ai/core/utils/constants/icon_path.dart';
// import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';
// import 'package:inprep_ai/features/interview/interview_details/start_interview/widget/next_button.dart';

// class QuestionWiseFeedback extends StatelessWidget {
//   QuestionWiseFeedback({super.key});

//   final StartInterviewController controller = Get.find<StartInterviewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Obx(() {
//         final response = controller.lastResponse;
//         final assessment = response['assessment'] ?? {};
//         final articulation = assessment['Articulation'] ?? {};
//         final behavioural = assessment['Behavioural_Cue'] ?? {};
//         final inprepScore = assessment['Inprep_Score']?['total_score'];
//         final summary = assessment['what_can_i_do_better']?['overall_feedback'];

//         debugPrint("The last updated response is: $response");

//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(
//               top: 60,
//               left: 20,
//               right: 20,
//               bottom: 60,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Question ${controller.questionNumber.value} feedback',
//                   style: getTextStyle(
//                     color: const Color(0xFF212121),
//                     fontSize: 24,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   'Question ${controller.questionNumber.value} Out of ${controller.questions.length} .   2:30 min',
//                   style: getTextStyle(
//                     color: Colors.black54,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 /// Articulation
//                 Row(
//                   children: [
//                     Image.asset(IconPath.speechIcon, width: 40, height: 40),
//                     const SizedBox(width: 5),
//                     Text(
//                       'Articulation',
//                       style: getTextStyle(
//                         color: const Color(0xFF212121),
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   '${articulation['feedback'] ?? 'No feedback available'}',
//                   textAlign: TextAlign.justify,
//                   style: getTextStyle(
//                     color: const Color(0xFF293649),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 /// Behavioural
//                 Row(
//                   children: [
//                     Image.asset(IconPath.bodyLanguage, width: 40, height: 40),
//                     const SizedBox(width: 5),
//                     Text(
//                       'Behavioural Cue',
//                       style: getTextStyle(
//                         color: const Color(0xFF212121),
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   '${behavioural['feedback'] ?? 'No feedback available'}',
//                   textAlign: TextAlign.justify,
//                   style: getTextStyle(
//                     color: const Color(0xFF293649),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 /// Inprep Score
//                 Text(
//                   'Inprep Score',
//                   style: getTextStyle(
//                     color: const Color(0xFF212121),
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   '${inprepScore ?? 0}',
//                   style: getTextStyle(
//                     color: const Color(0xFF212121),
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 /// Suggestions
//                 Text(
//                   'Suggestions',
//                   style: getTextStyle(
//                     color: const Color(0xff6a329f),
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   '${summary ?? 'No suggestions available'}',
//                   textAlign: TextAlign.justify,
//                   style: getTextStyle(
//                     color: const Color(0xFF174D31),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 /// Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.35,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: const Color(0xff6a329f)),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Retake',
//                                 style: getTextStyle(
//                                   color: const Color(0xff6a329f),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               Image.asset(
//                                 IconPath.retakeIcon,
//                                 height: 24,
//                                 width: 24,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     NextButton(onTap: controller.nextQuestion),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/widget/next_button.dart';

class QuestionWiseFeedback extends StatelessWidget {
  QuestionWiseFeedback({super.key});

  final StartInterviewController controller =
      Get.find<StartInterviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Obx(() {
        final response = controller.lastResponse;
        final assessment = response['assessment'] ?? {};
        final articulation = assessment['Articulation'] ?? {};
        final behavioural = assessment['Behavioural_Cue'] ?? {};
        final inprepScore = assessment['Inprep_Score']?['total_score'];
        final summary = assessment['what_can_i_do_better']?['overall_feedback'];

        debugPrint("The last updated response is: $response");

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${controller.questionNumber.value} feedback',
                  style: getTextStyle(
                    color: const Color(0xFF212121),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Question ${controller.questionNumber.value} Out of ${controller.questions.length} .   2:30 min',
                  style: getTextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 40),

                /// Articulation
                Row(
                  children: [
                    Image.asset(IconPath.speechIcon, width: 40, height: 40),
                    const SizedBox(width: 5),
                    Text(
                      'Articulation',
                      style: getTextStyle(
                        color: const Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${articulation['feedback'] ?? 'No feedback available'}',
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                /// Behavioural
                Row(
                  children: [
                    Image.asset(IconPath.bodyLanguage, width: 40, height: 40),
                    const SizedBox(width: 5),
                    Text(
                      'Behavioural Cue',
                      style: getTextStyle(
                        color: const Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${behavioural['feedback'] ?? 'No feedback available'}',
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                /// Inprep Score
                Text(
                  'Inprep Score',
                  style: getTextStyle(
                    color: const Color(0xFF212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${inprepScore ?? 0}',
                  style: getTextStyle(
                    color: const Color(0xFF212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 24),

                /// Suggestions
                Text(
                  'Suggestions',
                  style: getTextStyle(
                    color: const Color(0xff6a329f),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${summary ?? 'No suggestions available'}',
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF174D31),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                /// Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Call the retake function when the user taps the "Retake" button
                        controller.retakeQuestion();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xff6a329f)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Retake',
                                style: getTextStyle(
                                  color: const Color(0xff6a329f),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                IconPath.retakeIcon,
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    NextButton(onTap: controller.nextQuestion),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
