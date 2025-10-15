import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/auhe_custom_textfiled.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/about_me_contrller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/experience_controller.dart';

class Experience extends StatelessWidget {
  Experience({super.key});

  final ExperienceController controller = Get.put(ExperienceController());
  final AboutMeController aboutMeController = Get.put(
    AboutMeController(),
  ); // Inject AboutMeContrller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Obx(() {
          // Show loading indicator if skills are empty (optional)
          if (aboutMeController.skills.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Experience",
                        style: getTextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff212121),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...controller.experienceForms.map((formId) {
                      final controllers = controller.formControllers[formId]!;
                      return ExperienceForm(
                        key: ValueKey(formId),
                        controllers: controllers,
                        onRemove:
                            controller.experienceForms.length > 1
                                ? () => controller.removeExperienceForm(formId)
                                : null,
                        selectedSkillsNotifier: controller.selectedSkills,
                        onAddSkill: controller.addSkill,
                        onRemoveSkill: controller.removeSkill,
                        availableSkills:
                            aboutMeController.skills
                                .map((e) => e.name ?? '')
                                .toList(), // Pass skills names
                      );
                      // ignore: unnecessary_to_list_in_spreads
                    }).toList(),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: controller.addNewExperienceForm,
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff6a329f),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add More Experience",
                            style: getTextStyle(
                              color: const Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ExperienceForm extends StatelessWidget {
  final ExperienceFormControllers controllers;
  final VoidCallback? onRemove;
  final RxList<String> selectedSkillsNotifier;
  final Function(String) onAddSkill;
  final Function(String) onRemoveSkill;
  final List<String> availableSkills; // Add this

  const ExperienceForm({
    super.key,
    required this.controllers,
    this.onRemove,
    required this.selectedSkillsNotifier,
    required this.onAddSkill,
    required this.onRemoveSkill,
    required this.availableSkills, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onRemove != null) ...[
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
        ],
        Text(
          "Job Title",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        AuthCustomTextField(
          controller: controllers.jobTitleController,
          text: "",
        ),
        Text(
          "Employer Name",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        AuthCustomTextField(
          controller: controllers.employerNameController,
          text: "",
        ),
        Text(
          "City",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        AuthCustomTextField(controller: controllers.cityController, text: ""),
        const SizedBox(height: 8),
        // Your CountryPickerView here...
        const SizedBox(height: 8),
        Text(
          "Responsibilities",
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controllers.responsibilitiesController,
          maxLines: 4,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items:
              availableSkills
                  .map(
                    (skill) =>
                        DropdownMenuItem(value: skill, child: Text(skill)),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null && !selectedSkillsNotifier.contains(value)) {
              onAddSkill(value);
            }
          },
          hint: Text(
            'Select a skill',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ),

        const SizedBox(height: 10),
        Obx(() {
          return Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                selectedSkillsNotifier.map((skill) {
                  return Chip(
                    label: Text(
                      skill,
                      style: getTextStyle(
                        color: const Color(0xFF37BB74),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    deleteIcon: const Icon(
                      Icons.cancel,
                      size: 20,
                      color: Color(0xFF37BB74),
                    ),
                    onDeleted: () => onRemoveSkill(skill),
                    backgroundColor: const Color(0xffEBF8F1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }).toList(),
          );
        }),
        // The rest of your widget below, unchanged...

        // For brevity I’m not repeating the entire form here,
        // just the dropdown and chips part that changed.
      ],
    );
  }
}
