import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/common/widgets/auhe_custom_textfiled.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/about_me_contrller.dart';
import 'package:inprep_ai/features/profile_setup.dart/widgets/country_ui.dart';

class AboutMe extends StatelessWidget {
  final ValueNotifier<List<String>> selectedSkillsNotifier;
  final Function(String) onAddSkill;
  final Function(String) onRemoveSkill;
  final AboutMeController controller;

  const AboutMe({
    super.key,
    required this.selectedSkillsNotifier,
    required this.onAddSkill,
    required this.onRemoveSkill,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "About Me",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff212121),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "City",
                style: getTextStyle(
                  color: const Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              AuthCustomTextField(
                controller: controller.cityController,
                text: "",
              ),
              const SizedBox(height: 8),
              CountryPickerView(
                model: controller.countryModel,
                controller: controller.countryController,
              ),
              const SizedBox(height: 8),
              Text(
                "Summary",
                style: getTextStyle(
                  color: const Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.summaryController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Write summary about you',
                  labelStyle: getTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Skills",
                style: getTextStyle(
                  color: const Color(0xff333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    
                    border: OutlineInputBorder(),
                  ),
                  items: controller.skills.map((skill) {
                    return DropdownMenuItem<String>(
                      value: skill.name,
                      child: Text(skill.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
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
                );
              }),
              const SizedBox(height: 10),
              ValueListenableBuilder<List<String>>(
                valueListenable: selectedSkillsNotifier,
                builder: (context, selectedSkills, child) {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: selectedSkills.map((skill) {
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
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
