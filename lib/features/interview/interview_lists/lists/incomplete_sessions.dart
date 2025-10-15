import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/interview/interview_details/details/view/details_view.dart' show DetailsView;
import 'package:shimmer/shimmer.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';

class IncompleteSessions extends StatelessWidget {
  IncompleteSessions({super.key});

  final InterviewListController controller =
      Get.find<InterviewListController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Incomplete Sessions",
          style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 170,
          child: Obx(() {
            if (controller.isLoading.value) {
              // Show shimmer while loading
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: double.infinity,
                              width: 78,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 140,
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 100,
                                    height: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 80,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              // Show real data
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.interviewList.length,
                itemBuilder: (context, index) {
                  var session = controller.interviewList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFFEB3B),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: 78,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(session.img ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                    session.interviewName ?? '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: getTextStyle(
                                      color: const Color(0xFF212121),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${session.totalPositions} Job Titles',
                                  style: getTextStyle(
                                    color: const Color(0xFF676768),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => DetailsView(), arguments: [
                          session.interviewName,
                          session.img,
                          session.totalPositions,
                          session.description,
                          session.id,
                        ]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xff6a329f),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Resume",
                                            style: getTextStyle(
                                              color: const Color(0xff6a329f),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            IconPath.resumeIcon,
                                            width: 16,
                                            height: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
