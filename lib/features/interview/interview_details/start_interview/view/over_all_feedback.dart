import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart' show IconPath;
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/widget/to_improve_container.dart'
    show ToImproveContainer;
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';

class OverAllFeedback extends StatelessWidget {
  OverAllFeedback({super.key});

  final StartInterviewController controller =
      Get.find<StartInterviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Obx(() {
        final summary = controller.summary.value?.data?.assessment;
        if (summary == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Interview Feedback',
                  style: getTextStyle(
                    color: Color(0xFF212121),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '${controller.questionNumber.value}/${controller.questions.length.toString()} Questions Completed',
                ),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${summary.articulation?.score.toString()}/100',
                    style: getTextStyle(
                      color: Color(0xff6a329f),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(alignment: Alignment.center, child: Text('Your Score')),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset(IconPath.speechIcon, width: 40, height: 40),
                    SizedBox(width: 5),
                    Text(
                      'Articulation',
                      style: getTextStyle(
                        color: Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${summary.articulation?.feedback}',
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Image.asset(IconPath.bodyLanguage, width: 40, height: 40),
                    SizedBox(width: 5),
                    Text(
                      'Behavioural Cue',
                      style: getTextStyle(
                        color: Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '${summary.behaviouralCue?.feedback}',
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Confidence',
                  style: getTextStyle(
                    color: Color(0xFF212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF3A4C67), width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(child: Text('80%')),
                  ),
                ),
                SizedBox(height: 24),
                ToImproveContainer(),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // GestureDetector(
                    //   onTap: (){},
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.35,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(
                    //         color: Color(0xff6a329f)
                    //       )
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(
                    //         vertical: 10
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text('Retake',
                    //            style: getTextStyle(
                    //             color: Color(0xff6a329f),
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w500
                    //            ),
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Image.asset(IconPath.retakeIcon,
                    //            height: 24,
                    //            width: 24,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // StartNewButton(
                    //   onTap: () => Get.offAll(InterviewListView()),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(BottomNavbarView());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.898,
                        decoration: BoxDecoration(
                          color: Color(0xff6a329f),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              "Go to Home",
                              style: getTextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
