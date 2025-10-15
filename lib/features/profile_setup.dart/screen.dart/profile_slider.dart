// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/widgets/custom_button.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/manual_resume_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/about_me.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/education_cirtificate.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/experience.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/about_me_contrller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/education_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/experience_controller.dart';

class ProfileSlider extends StatelessWidget {
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);
  final PageController pageController = PageController();
  final int totalPages = 3;
  final ValueNotifier<List<String>> selectedSkillsNotifier = ValueNotifier<List<String>>([]);

  final AboutMeController aboutMeController = Get.put(AboutMeController());
  final ExperienceController experienceController = Get.put(ExperienceController());
  final EducationController educationController = Get.put(EducationController());

  Future<void> nextPage(BuildContext context) async {
    if (currentPageNotifier.value == 0) {
      final country = aboutMeController.countryModel.initialCountry;
      debugPrint("City: ${aboutMeController.cityController.text}");
      debugPrint("Country: ${country != null ? (country.name ?? country.isoCode) : 'No country selected'}");
      debugPrint("Summary: ${aboutMeController.summaryController.text}");
      debugPrint("Selected Skills: ${selectedSkillsNotifier.value.join(', ')}");
    }

    if (currentPageNotifier.value == 1) {
      for (String formId in experienceController.experienceForms) {
        final formControllers = experienceController.formControllers[formId];
        if (formControllers != null) {
          debugPrint("Experience Form ID: $formId");
          debugPrint("Job Title: ${formControllers.jobTitleController.text}");
          debugPrint("Employer Name: ${formControllers.employerNameController.text}");
          debugPrint("City: ${formControllers.cityController.text}");
          debugPrint("Responsibilities: ${formControllers.responsibilitiesController.text}");
          debugPrint("Selected Skills: ${experienceController.selectedSkills.join(', ')}");
        }
      }
    }

    if (currentPageNotifier.value == 2) {
      for (int i = 0; i < educationController.rowCount.value; i++) {
        debugPrint('Education Entry #${i + 1}:');
        debugPrint('School Name: ${educationController.schoolNameControllers[i].text}');
        debugPrint('Level of Education: ${educationController.educationLevels[i]}');
        debugPrint('Major: ${educationController.majorControllers[i].text}');
        debugPrint('Start Date: ${educationController.startDates[i]}');
        debugPrint('End Date: ${educationController.endDates[i]}');
      }
    }

    if (currentPageNotifier.value < totalPages - 1) {
      currentPageNotifier.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await saveResume();
      
    }
  }

  void addSkill(String skill) {
    if (!selectedSkillsNotifier.value.contains(skill)) {
      selectedSkillsNotifier.value = [...selectedSkillsNotifier.value, skill];
    }
  }

  void removeSkill(String skill) {
    selectedSkillsNotifier.value = selectedSkillsNotifier.value.where((s) => s != skill).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: currentPageNotifier,
                builder: (context, currentPage, child) {
                  return Row(
                    children: List.generate(totalPages, (index) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          height: 2.0,
                          decoration: BoxDecoration(
                            color: index <= currentPage ? Color(0xff6a329f) : Colors.grey[300],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    currentPageNotifier.value = index;
                  },
                  children: [
                    AboutMe(
                      selectedSkillsNotifier: selectedSkillsNotifier,
                      onAddSkill: addSkill,
                      onRemoveSkill: removeSkill,
                      controller: aboutMeController,
                    ),
                    Experience(),
                    EducationCertificate(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomButton1(
                title: "Continue",
                textcolor: const Color(0xffffffff),
                backgroundColor: const Color(0xff6a329f),
                onPress: () => nextPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
