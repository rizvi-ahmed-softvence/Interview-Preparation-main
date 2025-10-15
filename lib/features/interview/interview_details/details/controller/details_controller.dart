import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart' show Urls;
import 'package:inprep_ai/features/interview/interview_details/details/model/question_bank_model.dart';

class DetailsController extends GetxController {
  var title = ''.obs;
  var image = ''.obs;
  var positions = 0.obs;
  var description =
      'Lorem ipsum dolor sit amet consectetur. Mi accumsan orci aenean libero aenean. In risus purus ipsum nibh leo. Malesuada fames enim feugiat enim. Dolor aliquam libero facilisi nunc eget justo ante.'
          .obs;

  var id = ''.obs;        

  @override
  void onInit() {
    super.onInit();
    fetchQuestionBanks(); 
    if (Get.arguments != null && Get.arguments is List) {
      List<dynamic> arguments = Get.arguments;
      if (arguments.length >= 3) {
        title.value = arguments[0] is String ? arguments[0] : '';
        image.value = arguments[1] is String ? arguments[1] : '';
        positions.value = arguments[2] is int ? arguments[2] : 0;
        description.value = arguments[3] is String ? arguments[3] : '';
        id.value =  arguments[4] is String ? arguments[4] : '';
      }
    }
  }


  List<Map<String, dynamic>> categoryList = [
    {
      'title': 'Frontend Developer', 
    }, 
    {
      'title': 'Backend Developer', 
    }, 
    {
      'title': 'Full Stack Developer', 
    }, 
    {
      'title': 'Mobile App Developer', 
    }, 
    {
      'title': 'Problem Solving', 
    }, 
    {
      'title': 'Software Engineer in Test', 
    }, 
    {
      'title': 'UI/UX Developer', 
    }, 
  ]; 

  RxList<QuestionBank> questionBanks = <QuestionBank>[].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchQuestionBanks() async {
    try {
      isLoading.value = true;
      String? token = await SharedPreferencesHelper.getAccessToken();

      if (token == null) {
        Get.snackbar('Error', 'User not authenticated');
        return;
      }

      final url = Uri.parse('${Urls.baseUrl}/interview/get_question_bank?interview_id=${id.value}');
      final response = await http.get(
        url,
        headers: {
          'Authorization':  token,
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print("The question banks are: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final model = QuestionBankModel.fromJson(data);
        questionBanks.value = model.body ?? [];
      } else {
        Get.snackbar('Error', 'Failed to load question banks');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
