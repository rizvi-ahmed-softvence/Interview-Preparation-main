import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart' show AppColors;

import 'package:inprep_ai/features/interview/interview_details/category_details/controller%20/category_details_controller.dart'
    show CategoryDetailsController;
import 'package:inprep_ai/features/interview/interview_details/category_details/widgets/category_details_header.dart'
    show CategoryDetailsHeader;

import 'package:inprep_ai/features/interview/interview_details/category_details/widgets/overview_widget.dart';
import 'package:inprep_ai/features/interview/interview_details/category_details/widgets/start_mock_interview_container.dart';
import 'package:inprep_ai/features/interview/interview_details/category_details/widgets/what_to_expect.dart'
    show WhatToExpect;
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/start_interview_view.dart'
    show StartInterviewView;

class CategoryDetailsView extends StatelessWidget {
  CategoryDetailsView({super.key});

  final CategoryDetailsController controller = Get.put(
    CategoryDetailsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CategoryDetailsHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Padding(
                  // Wrap the Padding (and its Column child) with Obx
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      StartMockInterviewContainer(
                        onTap: () {
                          Get.to(
                            () => StartInterviewView(),
                            arguments: [
                              controller.id.value,
                              controller.interviewId.value,
                              controller.selectedExpectations
                                  .toList(), // Pass a copy of the list
                              controller.difficulty.value,
                              controller.questionType.value,
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OverviewWidget(
                            title: "Difficulty Level",
                            description: controller.difficulty.value,
                            isDropdown: true,
                            dropdownItems: [
                              "Beginner",
                              "Intermediate",
                              "Expert",
                            ],
                            selectedValue: controller.difficulty.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.difficulty.value = value;
                              }
                            },
                          ),
                          OverviewWidget(
                            title: "Question Type",
                            description: controller.questionType.value,
                            isDropdown: true,
                            dropdownItems: ["Multiple Choice", "Open Ended"],
                            selectedValue: controller.questionType.value,
                            onChanged: (value) {
                              if (value != null) {
                                controller.questionType.value = value;
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: OverviewWidget(
                          title: "${controller.duration.value.toString()} min",
                          description: 'Duration',
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.description.value,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF212121),
                        ),
                      ),
                      SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "What to Expect",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      WhatToExpect(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
