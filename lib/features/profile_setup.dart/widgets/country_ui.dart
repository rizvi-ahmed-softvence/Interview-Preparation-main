import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/country_controller.dart';

class CountryPickerView extends StatelessWidget {
  final CountryModel model;
  final CountryController controller;

  const CountryPickerView({
    super.key,
    required this.model,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style: getTextStyle(
            fontSize: 16,
            color: const Color(0xff333333),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        Obx(
          () => GestureDetector(
            onTap: () => controller.openCountryPickerDialog(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xff333333),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  CountryPickerUtils.getDefaultFlagImage(
                      model.selectedCountry.value),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      model.selectedCountry.value.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 24,
                    color: Color(0xff3A4C67),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}