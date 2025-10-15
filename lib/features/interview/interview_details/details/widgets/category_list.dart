import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar, Colors, Icons;
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/interview/interview_details/category_details/view/category_details_view.dart';
import 'package:inprep_ai/features/interview/interview_details/details/controller/details_controller.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  final DetailsController controller = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Obx(() {
        // Show shimmer if data is loading
        if (controller.isLoading.value) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ShimmerTile(),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.questionBanks.length,
          itemBuilder: (context, index) {
            var data = controller.questionBanks[index];
            return Padding(
              padding:  EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => CategoryDetailsView(),
                    arguments: [
                      data.questionBankName,
                      data.img,
                      data.duration,
                      data.description,
                      data.whatToExpect,
                      data.id,
                      controller.id.value,
                    ],
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Image.network(
                          data.img ?? IconPath.codeIcon,
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            data.questionBankName ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF212121),
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xff6a329f),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// Separate shimmer tile widget
class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
