// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';
// import 'package:inprep_ai/features/interview/interview_details/details/view/details_view.dart';
// import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';

// class AvailableMockInterviews extends StatelessWidget {
//   AvailableMockInterviews({super.key});

//   final InterviewListController controller = Get.find<InterviewListController>();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.99,
//           child: Obx(() {
//             if (controller.isLoading.value) {
//               // Show shimmer while loading
//               return ListView.builder(
//                 itemCount: 4,
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: Shimmer.fromColors(
//                       baseColor: Colors.grey.shade300,
//                       highlightColor: Colors.grey.shade100,
//                       child: Container(
//                         height: 80,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.all(12),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 64,
//                               height: 68,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 16,
//                                     width: 120,
//                                     color: Colors.white,
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Container(
//                                     height: 14,
//                                     width: 100,
//                                     color: Colors.white,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             CircleAvatar(
//                               radius: 16,
//                               backgroundColor: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               // Show list once data is loaded
//               return ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 padding: EdgeInsets.zero,
//                 itemCount: controller.allInterviews.length,
//                 itemBuilder: (context, index) {
//                   var availablemockinterviews = controller.allInterviews[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.to(() => DetailsView(), arguments: [
//                           availablemockinterviews.interviewName,
//                           availablemockinterviews.img,
//                           availablemockinterviews.totalPositions,
//                           availablemockinterviews.description,
//                           availablemockinterviews.id,
//                         ]);
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.all(12),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 64,
//                               height: 68,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 image: DecorationImage(
//                                   image: NetworkImage(availablemockinterviews.img),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             SizedBox(
//                               width: 180,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     availablemockinterviews.interviewName,
//                                     style: getTextStyle(
//                                         color: const Color(0xFF212121),
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Text(
//                                     "${availablemockinterviews.totalPositions} Job Titles",
//                                     style: getTextStyle(
//                                         color: const Color(0xFFAFAFAF),
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             const CircleAvatar(
//                               radius: 16,
//                               backgroundColor: Color(0xff6a329f),
//                               child: Icon(Icons.arrow_forward, color: Colors.white),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           }),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/interview/interview_details/details/view/details_view.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';

class AvailableMockInterviews extends StatelessWidget {
  AvailableMockInterviews({super.key});

  final InterviewListController controller = Get.find<InterviewListController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.38,
          child: Obx(() {
            if (controller.isLoading.value) {
              // Show shimmer while loading
              return ListView.builder(
                itemCount: 4,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 68,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 120,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 14,
                                    width: 100,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              // Show filtered list once data is loaded
              return ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: controller.filteredInterviews.length, // Use filteredInterviews
                itemBuilder: (context, index) {
                  var availablemockinterviews = controller.filteredInterviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => DetailsView(), arguments: [
                          availablemockinterviews.interviewName,
                          availablemockinterviews.img,
                          availablemockinterviews.totalPositions,
                          availablemockinterviews.description,
                          availablemockinterviews.id,
                        ]);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF6a329f).withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 68,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(availablemockinterviews.img),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    availablemockinterviews.interviewName,
                                    style: getTextStyle(
                                        color: const Color(0xFF212121),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${availablemockinterviews.totalPositions} Job Titles",
                                    style: getTextStyle(
                                        color: const Color(0xFFAFAFAF),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xff6a329f),
                              child: Icon(Icons.arrow_forward, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
        
      ],
    );
  }
}