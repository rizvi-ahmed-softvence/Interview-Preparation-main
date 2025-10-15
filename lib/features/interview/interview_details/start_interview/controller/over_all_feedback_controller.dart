import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart' show SharedPreferencesHelper;
import 'package:inprep_ai/core/urls/endpint.dart' show Urls;
import 'package:inprep_ai/features/interview/interview_details/start_interview/model/summery_model.dart' show SummaryModel;

class OverAllFeedbackController extends GetxController {
  var isLoading = true.obs;
  var summary = Rxn<SummaryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchSummary();
  }

  Future<void> fetchSummary() async {
    try {
      isLoading.value = true;
      String? token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse('${Urls.baseUrl}video/getSummary?questionBank_id=684017f4e17788714fd2ad8c'),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        summary.value = SummaryModel.fromJson(jsonBody);
      } else {
        Get.snackbar('Error', 'Failed to fetch summary: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}