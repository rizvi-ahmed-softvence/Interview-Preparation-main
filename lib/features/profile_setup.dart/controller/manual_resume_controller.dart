// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/about_me_contrller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/education_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/experience_controller.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/resume_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/update_resume.dart'
    show Updateresume, updateresumeFromJson;
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/genarated_about_me.dart';

// Assume these controllers are passed or accessible:
final AboutMeController aboutMeController = Get.find();
final ExperienceController experienceController = Get.find();
final EducationController educationController = Get.find();

// Future<void> saveResume() async {
//   try {
//     debugPrint('DEBUG: Starting saveResume function');
//     EasyLoading.show(status: "Saving resume...");
//     debugPrint('DEBUG: EasyLoading shown with status "Saving resume..."');

//     // Retrieve the access token using SharedPreferencesHelper
//     String? accessToken = await SharedPreferencesHelper.getAccessToken();
//     debugPrint('DEBUG: Access token retrieved: $accessToken');
//     if (accessToken == null || accessToken.isEmpty) {
//       debugPrint('DEBUG: Access token is null or empty, throwing exception');
//       throw Exception('No access token found.');
//     }

//     // Prepare Address
//     final address = Address(
//       city: aboutMeController.cityController.text,
//       country: aboutMeController.countryModel.initialCountry?.name ?? '',
//     );
//     debugPrint(
//       'DEBUG: Address created - City: ${address.city}, Country: ${address.country}',
//     );

//     // Prepare technicalSkills
//     List<String> technicalSkills =
//         aboutMeController.skills
//             .where(
//               (skill) =>
//                   experienceController.selectedSkills.contains(skill.name),
//             )
//             .map((e) => e.name ?? '')
//             .toList();
//     debugPrint('DEBUG: Technical skills prepared: $technicalSkills');

//     // Prepare Experience
//     List<Experience> experiences =
//         experienceController.experienceForms.map((formId) {
//           final controllers = experienceController.formControllers[formId]!;
//           final country = controllers.countryModel.initialCountry?.name ?? '';
//           debugPrint('DEBUG: Processing experience form ID: $formId');
//           debugPrint('DEBUG: Experience country: $country');

//           return Experience(
//             jobTitle: controllers.jobTitleController.text,
//             company: controllers.employerNameController.text,
//             city: controllers.cityController.text,
//             country: country,
//             responsibilities: controllers.responsibilitiesController.text,
//             skills: experienceController.selectedSkills.toList(),
//             startDate: experienceController.selectDate.value,
//             endDate: experienceController.selectDate1.value,
//           );
//         }).toList();
//     debugPrint(
//       'DEBUG: Experiences prepared: ${experiences.map((e) => {'jobTitle': e.jobTitle, 'company': e.company, 'city': e.city, 'country': e.country, 'responsibilities': e.responsibilities, 'skills': e.skills, 'startDate': e.startDate, 'endDate': e.endDate}).toList()}',
//     );

//     // Prepare Education list
//     List<Education> educationList = [];
//     for (int i = 0; i < educationController.rowCount.value; i++) {
//       educationList.add(
//         Education(
//           institution: educationController.schoolNameControllers[i].text,
//           degree: educationController.educationLevels[i],
//           majorField: educationController.majorControllers[i].text,
//           startDate: educationController.startDates[i],
//           completionDate: educationController.endDates[i],
//         ),
//       );
//       debugPrint(
//         'DEBUG: Education entry $i - Institution: ${educationList[i].institution}, '
//         'Degree: ${educationList[i].degree}, Major: ${educationList[i].majorField}, '
//         'Start: ${educationList[i].startDate}, End: ${educationList[i].completionDate}',
//       );
//     }
//     debugPrint(
//       'DEBUG: Education list prepared: ${educationList.length} entries',
//     );

//     // Build ResumeData object
//     final resumeData = ResumeData(
//       summary: aboutMeController.summaryController.text,
//       address: address,
//       technicalSkills: technicalSkills,
//       experience:
//           experiences.isNotEmpty
//               ? experiences.first
//               : Experience(
//                 jobTitle: '',
//                 company: '',
//                 city: '',
//                 country: '',
//                 responsibilities: '',
//                 skills: [],
//                 startDate: '',
//                 endDate: '',
//               ),
//       education: educationList,
//     );
//     debugPrint(
//       'DEBUG: ResumeData created - Summary: ${resumeData.summary}, '
//       'Address: {City: ${resumeData.address.city}, Country: ${resumeData.address.country}}, '
//       'TechnicalSkills: ${resumeData.technicalSkills}, '
//       'Experience: {JobTitle: ${resumeData.experience.jobTitle}, Company: ${resumeData.experience.company}}, '
//       'Education: ${resumeData.education.length} entries',
//     );

//     // Send PUT request
//     final Uri url = Uri.parse(Urls.updateresume);
//     debugPrint('DEBUG: URL for PUT request: $url');
//     final response = await http.put(
//       url,
//       headers: {
//         'Authorization': accessToken,
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(resumeData.toJson()),
//     );
//     debugPrint(
//       'DEBUG: HTTP PUT request sent with headers: {Authorization: $accessToken, Content-Type: application/json}, '
//       'Body: ${jsonEncode(resumeData.toJson())}',
//     );
//     debugPrint('DEBUG: Response status code: ${response.statusCode}');
//     debugPrint('DEBUG: Response body: ${response.body}');

//     if (response.statusCode == 200) {
//       debugPrint(
//         'DEBUG: Resume updated successfully, navigating to PersonalizedInterviewerScreen',
//       );
//       Updateresume updateresume = updateresumeFromJson(response.body);
//       EasyLoading.showSuccess('Resume updated successfully');
//       // Get.to(PersonalizedInterviewerScreen());
//       Get.offAll(GenaratedAboutMe());
//     } else {
//       debugPrint(
//         'DEBUG: Failed to update resume - Status: ${response.statusCode}, Body: ${response.body}',
//       );
//       EasyLoading.showError(
//         'Failed to update resume: please Fill all the fields',
//       );
//     }
//   } catch (e) {
//     debugPrint('DEBUG: Error caught in saveResume: $e');
//     EasyLoading.showError('Error saving resume: $e');
//   } finally {
//     debugPrint('DEBUG: Dismissing EasyLoading');
//     EasyLoading.dismiss();
//   }
// }



Future<void> saveResume() async {
  try {
    debugPrint('DEBUG: Starting saveResume function');
    EasyLoading.show(status: "Saving resume...");
    debugPrint('DEBUG: EasyLoading shown with status "Saving resume..."');

    // Retrieve the access token using SharedPreferencesHelper
    String? accessToken = await SharedPreferencesHelper.getAccessToken();
    debugPrint('DEBUG: Access token retrieved: $accessToken');
    if (accessToken == null || accessToken.isEmpty) {
      debugPrint('DEBUG: Access token is null or empty, throwing exception');
      throw Exception('No access token found.');
    }

    // Prepare Address
    final address = Address(
      city: aboutMeController.cityController.text,
      country: aboutMeController.countryModel.initialCountry?.name ?? '',
    );
    debugPrint(
      'DEBUG: Address created - City: ${address.city}, Country: ${address.country}',
    );

    // Prepare technicalSkills
    List<String> technicalSkills = aboutMeController.skills
        .where(
          (skill) => experienceController.selectedSkills.contains(skill.name),
        )
        .map((e) => e.name ?? '')
        .toList();
    debugPrint('DEBUG: Technical skills prepared: $technicalSkills');

    // Prepare Experience
    List<Experience> experiences = experienceController.experienceForms.map((formId) {
      final controllers = experienceController.formControllers[formId]!;
      final country = controllers.countryModel.initialCountry?.name ?? '';
      debugPrint('DEBUG: Processing experience form ID: $formId');
      debugPrint('DEBUG: Experience country: $country');

      return Experience(
        jobTitle: controllers.jobTitleController.text,
        company: controllers.employerNameController.text, // Fixed typo
        city: controllers.cityController.text,
        country: country,
        responsibilities: controllers.responsibilitiesController.text,
        skills: experienceController.selectedSkills.toList(),
        startDate: experienceController.selectDate.value,
        endDate: experienceController.selectDate1.value,
      );
    }).toList();
    debugPrint(
      'DEBUG: Experiences prepared: ${experiences.map((e) => {'jobTitle': e.jobTitle, 'company': e.company, 'city': e.city, 'country': e.country, 'responsibilities': e.responsibilities, 'skills': e.skills, 'startDate': e.startDate, 'endDate': e.endDate}).toList()}',
    );

    // Prepare Education list
    List<Education> educationList = [];
    for (int i = 0; i < educationController.rowCount.value; i++) {
      educationList.add(
        Education(
          institution: educationController.schoolNameControllers[i].text,
          degree: educationController.educationLevels[i],
          majorField: educationController.majorControllers[i].text,
          startDate: educationController.startDates[i],
          completionDate: educationController.endDates[i],
        ),
      );
      debugPrint(
        'DEBUG: Education entry $i - Institution: ${educationList[i].institution}, '
        'Degree: ${educationList[i].degree}, Major: ${educationList[i].majorField}, '
        'Start: ${educationList[i].startDate}, End: ${educationList[i].completionDate}',
      );
    }
    debugPrint(
      'DEBUG: Education list prepared: ${educationList.length} entries',
    );

    // Build ResumeData object
    final resumeData = ResumeData(
      summary: aboutMeController.summaryController.text,
      address: address,
      technicalSkills: technicalSkills,
      experience: experiences.isNotEmpty
          ? experiences.first
          : Experience(
              jobTitle: '',
              company: '', // Fixed typo
              city: '',
              country: '',
              responsibilities: '',
              skills: [],
              startDate: '',
              endDate: '',
            ),
      education: educationList,
    );
    debugPrint(
      'DEBUG: ResumeData created - Summary: ${resumeData.summary}, '
      'Address: {City: ${resumeData.address.city}, Country: ${resumeData.address.country}}, '
      'TechnicalSkills: ${resumeData.technicalSkills}, '
      'Experience: {JobTitle: ${resumeData.experience.jobTitle}, Company: ${resumeData.experience.company}}, '
      'Education: ${resumeData.education.length} entries',
    );

    // Send PUT request
    final Uri url = Uri.parse(Urls.updateresume);
    debugPrint('DEBUG: URL for PUT request: $url');
    final response = await http.put(
      url,
      headers: {
        'Authorization': accessToken,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(resumeData.toJson()),
    );
    debugPrint(
      'DEBUG: HTTP PUT request sent with headers: {Authorization: $accessToken, Content-Type: application/json}, '
      'Body: ${jsonEncode(resumeData.toJson())}',
    );
    debugPrint('DEBUG: Response status code: ${response.statusCode}');
    debugPrint('DEBUG: Response body: ${response.body}');

    if (response.statusCode == 200) {
      debugPrint(
        'DEBUG: Resume updated successfully, navigating to GenaratedAboutMe',
      );
      Updateresume updateresume = updateresumeFromJson(response.body);
      EasyLoading.showSuccess('Resume updated successfully');
      // Navigate to GenaratedAboutMe with the Updateresume object
      Get.offAll(
        GenaratedAboutMe(),
        arguments: updateresume, // Pass the Updateresume object
      );
    } else {
      debugPrint(
        'DEBUG: Failed to update resume - Status: ${response.statusCode}, Body: ${response.body}',
      );
      EasyLoading.showError(
        'Failed to update resume: please Fill all the fields',
      );
    }
  } catch (e) {
    debugPrint('DEBUG: Error caught in saveResume: $e');
    EasyLoading.showError('Error saving resume: $e');
  } finally {
    debugPrint('DEBUG: Dismissing EasyLoading');
    EasyLoading.dismiss();
  }
}
