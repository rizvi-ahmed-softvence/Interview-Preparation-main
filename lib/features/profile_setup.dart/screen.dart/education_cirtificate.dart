import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/education_controller.dart';

class EducationCertificate extends StatelessWidget {
  EducationCertificate({super.key});

  final EducationController educationController =
      Get.find<EducationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Education & Certificate",
                    style: TextStyle(
                      color: Color(0xff212121),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: educationController.rowCount.value,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "School Name",
                                        style: getTextStyle(
                                          color: const Color(0xff333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      TextField(
                                        controller:
                                            educationController
                                                .schoolNameControllers[index],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Level of education",
                                        style: getTextStyle(
                                          color: Color(0xff333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Obx(
                                        () => DropdownButtonFormField<String>(
                                          value:
                                              educationController
                                                  .educationLevels[index],
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                          isExpanded: true,
                                          items:
                                              [
                                                    'Associate Degree',
                                                    'Bachelor Degree',
                                                    'Master Degree',
                                                    'PhD',
                                                    'Professional Certificate',
                                                  ]
                                                  .map(
                                                    (level) => DropdownMenuItem(
                                                      value: level,
                                                      child: Text(level),
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              educationController
                                                  .updateEducationLevel(
                                                    index,
                                                    value,
                                                  );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Major",
                              style: getTextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              controller:
                                  educationController.majorControllers[index],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Start Date",
                              style: getTextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Obx(
                              () => Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Color(0xFF78828A)),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => selectDate2(context, index),
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: Color(0xFF00BA0B),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Select a day',
                                          style: getTextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          educationController.startDates[index],
                                          style: getTextStyle(
                                            color: Color(0xFF00BA0B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "End Date",
                              style: getTextStyle(
                                color: Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Obx(
                              () => Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Color(0xFF78828A)),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => selectDate3(context, index),
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: Color(0xFF00BA0B),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Select a day',
                                          style: getTextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          educationController.endDates[index],
                                          style: getTextStyle(
                                            color: Color(0xFF00BA0B),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    educationController.addRow();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xffEBEDF0),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add",
                              style: getTextStyle(
                                color: Color(0xff3A4C67),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.add, color: Color(0xff3A4C67), size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate2(BuildContext context, int index) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF00BA0B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate =
          "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
      educationController.updateStartDate(index, formattedDate);
    }
  }

  // Future<void> selectDate3(BuildContext context, int index) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: Color(0xFF00BA0B),
  //             onPrimary: Colors.white,
  //             onSurface: Colors.black,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (pickedDate != null) {
  //     final formattedDate =
  //         "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";
  //     educationController.updateEndDate(index, formattedDate);
  //   }
  // }

  Future<void> selectDate3(BuildContext context, int index) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Color(0xFF00BA0B),
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    // Format the selected end date
    final formattedEndDate =
        "${pickedDate.day.toString().padLeft(2, '0')}.${pickedDate.month.toString().padLeft(2, '0')}.${pickedDate.year}";

    // Parse the start date and end date for comparison
    final startDate = DateTime.parse(educationController.startDates[index].split('.').reversed.join('-'));  // Convert start date to DateTime
    final endDate = DateTime.parse(formattedEndDate.split('.').reversed.join('-'));  // Convert selected end date to DateTime

    // Check if end date is before start date
    if (endDate.isBefore(startDate)) {
      // Show a snackbar message indicating the error
      Get.snackbar(
        'Invalid Date Range',
        'End date cannot be earlier than start date',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // If valid, update the end date
      educationController.updateEndDate(index, formattedEndDate);
    }
  }
}

}
