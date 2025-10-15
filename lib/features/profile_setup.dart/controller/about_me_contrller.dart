import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/skills_model.dart';
import 'package:flutter/material.dart';
import 'package:inprep_ai/features/profile_screen/model/country_model.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/country_controller.dart';
import 'package:country_pickers/utils/utils.dart';

class AboutMeController extends GetxController {
  var skills = <Data>[].obs;

  final TextEditingController cityController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final CountryModel countryModel = CountryModel(
    initialCountry: CountryPickerUtils.getCountryByIsoCode('GB'), // Default UK
  );
  late final CountryController countryController;

  @override
  void onInit() {
    super.onInit();
    countryController = CountryController(
      model: countryModel,
      onCountryUpdated: () {
        debugPrint("Country updated to: ${countryModel.initialCountry?.name ?? 'null'}");
      },
    );
    getAllSkills();
  }

  Future<void> getAllSkills() async {
  try {
    EasyLoading.show(status: "Loading skills data...");

    // Retrieve the access token using SharedPreferencesHelper
    String? accessToken = await SharedPreferencesHelper.getAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      throw Exception('No access token found.');
    }

    final Uri url = Uri.parse(Urls.getAllSkills);

    final response = await http.get(
      url,
      headers: {
        'Authorization': accessToken,  // 'Bearer' added for token authorization
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        final skillsResponse = Skills.fromJson(responseData);
        if (skillsResponse.data != null) {
          skills.assignAll(skillsResponse.data!);
        }
      } else {
        throw Exception(
          'Failed to fetch skills data: ${responseData['message']}',
        );
      }
    } else {
      throw Exception(
        'Failed to load skills, status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    EasyLoading.showError("Failed to load skills data: $e");
  } finally {
    EasyLoading.dismiss();
  }
}


  @override
  void onClose() {
    cityController.dispose();
    summaryController.dispose();
    super.onClose();
  }
}
