import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationController extends GetxController {
  var rowCount = 1.obs;

  RxList<TextEditingController> schoolNameControllers = <TextEditingController>[TextEditingController()].obs;
  RxList<TextEditingController> majorControllers = <TextEditingController>[TextEditingController()].obs;
  RxList<String> educationLevels = <String>['PhD'].obs;

  RxList<String> startDates = ['DD.MM.YYYY'].obs;
  RxList<String> endDates = ['DD.MM.YYYY'].obs;

  static const int maxRows = 3;

  void addRow() {
    if (rowCount.value < maxRows) {
      rowCount.value++;
      schoolNameControllers.add(TextEditingController());
      majorControllers.add(TextEditingController());
      educationLevels.add('PhD');
      startDates.add('DD.MM.YYYY');
      endDates.add('DD.MM.YYYY');
    } else {
      Get.snackbar(
        'Limit Reached',
        'You can add up to $maxRows education entries only.',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void updateEducationLevel(int index, String level) {
    while (index >= educationLevels.length) {
      educationLevels.add('');
    }
    educationLevels[index] = level;
  }

  void updateStartDate(int index, String date) {
    while (index >= startDates.length) {
      startDates.add('DD.MM.YYYY');
    }
    startDates[index] = date;
  }

  void updateEndDate(int index, String date) {
    while (index >= endDates.length) {
      endDates.add('DD.MM.YYYY');
    }
    endDates[index] = date;
  }

  @override
  void onClose() {
    for (var controller in schoolNameControllers) {
      controller.dispose();
    }
    for (var controller in majorControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
