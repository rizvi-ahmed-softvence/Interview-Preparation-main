// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart'
//     show getTextStyle;
// import 'package:inprep_ai/core/utils/constants/colors.dart';
// import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';
// import 'package:inprep_ai/features/interview/interview_lists/lists/available_mock_interviews.dart'
//     show AvailableMockInterviews;
// import 'package:inprep_ai/features/interview/interview_lists/lists/incomplete_sessions.dart'
//     show IncompleteSessions;
// import 'package:inprep_ai/features/interview/interview_lists/widgets/search_textfield.dart';

// class InterviewListView extends StatelessWidget {
//   InterviewListView({super.key});

//   final InterviewListController controller = Get.put(InterviewListController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryBackground,
//       body: Padding(
//         padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               CustomTextField(
//                 hintText: "Search Interview ... ",
//                 controller: controller.searchController,
//                 suffixIcon: const Icon(
//                   Icons.search,
//                   size: 28,
//                   color: Color(0xFFABB7C2),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // ✅ Conditionally show IncompleteSessions
//               Obx(() {
//                 if (controller.interviewList.isNotEmpty) {
//                   return Column(
//                     children:  [
//                       IncompleteSessions(),
                       
//                       SizedBox(height: 20),
//                     ],
//                   );
//                 } else {
//                   return const SizedBox.shrink(); // don't render anything
//                 }
//               }),

//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Available Mock Interviews",
//                   style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               AvailableMockInterviews(),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';
import 'package:inprep_ai/features/interview/interview_lists/lists/available_mock_interviews.dart' show AvailableMockInterviews;
import 'package:inprep_ai/features/interview/interview_lists/lists/incomplete_sessions.dart' show IncompleteSessions;
import 'package:inprep_ai/features/interview/interview_lists/widgets/search_textfield.dart';

class InterviewListView extends StatelessWidget {
  const InterviewListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller lazily
    Get.lazyPut(() => InterviewListController());

    final InterviewListController controller = Get.find<InterviewListController>();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                hintText: "Search Interview ... ",
                controller: controller.searchController,
                suffixIcon: const Icon(
                  Icons.search,
                  size: 28,
                  color: Color(0xFF6a329f),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.interviewList.isNotEmpty) {
                  return Column(
                    children: [
                      IncompleteSessions(),
                      SizedBox(height: 20),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Mock Interviews",
                  style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 15),
              AvailableMockInterviews(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}