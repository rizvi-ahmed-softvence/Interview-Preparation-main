import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/interview/interview_details/category_details/controller%20/category_details_controller.dart';

class WhatToExpect extends StatelessWidget {
  WhatToExpect({super.key});

  final CategoryDetailsController controller = Get.find<CategoryDetailsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: controller.whatToExpect.length,
        itemBuilder: (context, index) {
          final item = controller.whatToExpect[index];

          // ✅ Each item observes its own selection status
          return Obx(() {
            final isSelected = controller.selectedExpectations.contains(item);

            return GestureDetector(
              onTap: () => controller.toggleSelection(item),
              child: Padding(
                padding:  EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? Colors.green : Colors.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: isSelected
                            ?  Icon(Icons.check, color: Colors.white, size: 18)
                            : null,
                      ),
                       SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Text(
                          item,
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:  Color(0xFF212121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
