// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
// import 'package:inprep_ai/core/urls/endpint.dart' show Urls;
// import 'package:inprep_ai/features/interview/interview_lists/moddel/incomplete_interview_model.dart';
// import 'package:inprep_ai/features/interview/interview_lists/moddel/interview_model.dart' show Interview, MockInterviewResponse;

// class InterviewListController extends GetxController {
//   var searchController = TextEditingController(); 

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMockInterviews();
//     fetchIncompleteInterviews(); 
//   }


//   var isLoading = false.obs;
//   var allInterviews = <Interview>[].obs;
//   var suggestedInterviews = <Interview>[].obs;

//   Future<void> fetchMockInterviews() async {
//     try {
//       isLoading(true);
//       String? token = await SharedPreferencesHelper.getAccessToken();

//       final response = await http.get(
//         Uri.parse('${Urls.baseUrl}/interview/get_mock_interview'),
//         headers: {
//           'Authorization': token!,
//           'Content-Type': 'application/json',
//         },
//       );

//       if (kDebugMode) {
//         print("The interviews are: ${response.body}");
//       } 

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final mockResponse = MockInterviewResponse.fromJson(data);

//         allInterviews.assignAll(mockResponse.body.allInterviews);
//         suggestedInterviews.assignAll(mockResponse.body.suggested);
//       } else {
//         Get.snackbar("Error", "Failed to load interviews: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }


//    var interviewList = <IncompleteInterview>[].obs;

//    Future<void> fetchIncompleteInterviews() async {
//     try {
//       isLoading.value = true;
//       final String? token = await SharedPreferencesHelper.getAccessToken();

//       final response = await http.get(
//         Uri.parse('${Urls.baseUrl}/interview/getIncompleteInterviews'),
//         headers: {
//           'Authorization': token!,
//           'Content-Type': 'application/json',
//         },
//       );


//       debugPrint("The imcomplete interviews are: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final result = IncompleteInterviewResponse.fromJson(data);
//         interviewList.value = result.body;
//       } else {
//         Get.snackbar("Error", "Failed to fetch interviews");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
// import 'package:inprep_ai/core/urls/endpint.dart' show Urls;
// import 'package:inprep_ai/features/interview/interview_lists/moddel/incomplete_interview_model.dart';
// import 'package:inprep_ai/features/interview/interview_lists/moddel/interview_model.dart' show Interview, MockInterviewResponse;

// class InterviewListController extends GetxController {
//   var searchController = TextEditingController();
//   var isLoading = false.obs;
//   var allInterviews = <Interview>[].obs;
//   var suggestedInterviews = <Interview>[].obs;
//   var interviewList = <IncompleteInterview>[].obs;
//   var filteredInterviews = <Interview>[].obs; // New list for filtered results
//   var searchQuery = ''.obs; // Store the search query

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMockInterviews();
//     fetchIncompleteInterviews();
//     // Add listener to search controller to filter interviews on text change
//     searchController.addListener(() {
//       searchQuery.value = searchController.text;
//       filterInterviews();
//     });
//   }

//   @override
//   void onClose() {
//     searchController.dispose(); // Clean up controller
//     super.onClose();
//   }

//   // Filter interviews based on search query
//   void filterInterviews() {
//     final query = searchQuery.value.toLowerCase();
//     if (query.isEmpty) {
//       filteredInterviews.assignAll(allInterviews); // Show all if query is empty
//     } else {
//       filteredInterviews.assignAll(
//         allInterviews.where((interview) =>
//           interview.interviewName.toLowerCase().contains(query) ||
//           interview.description.toLowerCase().contains(query)
//         ).toList(),
//       );
//     }
//   }

//   Future<void> fetchMockInterviews() async {
//     try {
//       isLoading(true);
//       String? token = await SharedPreferencesHelper.getAccessToken();

//       final response = await http.get(
//         Uri.parse('${Urls.baseUrl}/interview/get_mock_interview'),
//         headers: {
//           'Authorization': token!,
//           'Content-Type': 'application/json',
//         },
//       );

//       if (kDebugMode) {
//         print("The interviews are: ${response.body}");
//       }

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final mockResponse = MockInterviewResponse.fromJson(data);

//         allInterviews.assignAll(mockResponse.body.allInterviews);
//         suggestedInterviews.assignAll(mockResponse.body.suggested);
//         filteredInterviews.assignAll(mockResponse.body.allInterviews); // Initialize filtered list
//       } else {
//         Get.snackbar("Error", "Failed to load interviews: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchIncompleteInterviews() async {
//     try {
//       isLoading.value = true;
//       final String? token = await SharedPreferencesHelper.getAccessToken();

//       final response = await http.get(
//         Uri.parse('${Urls.baseUrl}/interview/getIncompleteInterviews'),
//         headers: {
//           'Authorization': token!,
//           'Content-Type': 'application/json',
//         },
//       );

//       debugPrint("The incomplete interviews are: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final result = IncompleteInterviewResponse.fromJson(data);
//         interviewList.value = result.body;
//       } else {
//         Get.snackbar("Error", "Failed to fetch interviews");
//       }
//     } catch (e) {
//       Get.snackbar("Exception", e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart' show Urls;
import 'package:inprep_ai/features/interview/interview_lists/moddel/incomplete_interview_model.dart';
import 'package:inprep_ai/features/interview/interview_lists/moddel/interview_model.dart' show Interview, MockInterviewResponse;

class InterviewListController extends GetxController {
  var searchController = TextEditingController();
  var isLoading = false.obs;
  var allInterviews = <Interview>[].obs;
  var suggestedInterviews = <Interview>[].obs;
  var interviewList = <IncompleteInterview>[].obs;
  var filteredInterviews = <Interview>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMockInterviews();
    fetchIncompleteInterviews();
    // Add listener to search controller
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      filterInterviews();
    });
  }

  @override
  void onClose() {
    // Remove listener and dispose controller
    searchController.removeListener(() {
      searchQuery.value = searchController.text;
      filterInterviews();
    });
    searchController.dispose();
    super.onClose();
  }

  // Filter interviews based on search query
  void filterInterviews() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredInterviews.assignAll(allInterviews);
    } else {
      filteredInterviews.assignAll(
        allInterviews.where((interview) =>
            interview.interviewName.toLowerCase().contains(query) ||
            interview.description.toLowerCase().contains(query)).toList(),
      );
    }
  }

  Future<void> fetchMockInterviews() async {
    try {
      isLoading(true);
      String? token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/interview/get_mock_interview'),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
        },
      );

      if (kDebugMode) {
        print("The interviews are: ${response.body}");
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final mockResponse = MockInterviewResponse.fromJson(data);

        allInterviews.assignAll(mockResponse.body.allInterviews);
        suggestedInterviews.assignAll(mockResponse.body.suggested);
        filteredInterviews.assignAll(mockResponse.body.allInterviews);
      } else {
        Get.snackbar("Error", "Failed to load interviews: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchIncompleteInterviews() async {
    try {
      isLoading.value = true;
      final String? token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/interview/getIncompleteInterviews'),
        headers: {
          'Authorization': token!,
          'Content-Type': 'application/json',
        },
      );

      debugPrint("The incomplete interviews are: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = IncompleteInterviewResponse.fromJson(data);
        interviewList.value = result.body;
      } else {
        Get.snackbar("Error", "Failed to fetch interviews");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}