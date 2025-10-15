import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:camera/camera.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/model/summery_model.dart'
    show SummaryModel;
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/over_all_feedback.dart';
import 'package:inprep_ai/routes/app_routes.dart' show AppRoute;
import 'package:path_provider/path_provider.dart';

class StartInterviewController extends GetxController {
  var questions = <Map<String, dynamic>>[].obs;
  var currentQuestionIndex = 0.obs;
  var isLoading = false.obs;
  CameraController? cameraController;
  var isRecording = false.obs;
  String? videoPath;
  var questionNumber = 1.obs;
  var id = "".obs;
  var interviewId = "".obs;
  var lastResponse = {}.obs;

  var selectedExpectations = <String>[].obs;
  var difficulty = ''.obs;
  var questionType = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // ✅ Safely extract and validate Get.arguments
    final args = Get.arguments;
    if (args == null || args is! List || args.length < 2) {
      Get.snackbar(
        'Error',
        'Invalid or missing arguments passed to the interview',
      );
      return;
    }

    id.value = args[0];
    interviewId.value = args[1];

    selectedExpectations.value = List<String>.from(args[2]);
    difficulty.value = args[3];
    questionType.value = args[4];

    if (kDebugMode) {
      print("The id is: ${id.value}");
      print("The interviewId is: ${interviewId.value}");
      print("Selected Expectations: ${selectedExpectations.join(', ')}");
      print("Difficulty: ${difficulty.value}");
      print("Question Type: ${questionType.value}");
    }
    fetchQuestions();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    cameraController = CameraController(
      frontCamera, 
      ResolutionPreset.medium,
      enableAudio: true, // Optional: Include if you need audio in recordings
      );
    await cameraController!.initialize();
    update();
  }

  var history = <Map<String, dynamic>>[].obs;

  Future<void> fetchQuestions() async {
  isLoading.value = true;
  try {
    String? token = await SharedPreferencesHelper.getAccessToken();
    if (token == null) {
      Get.snackbar('Error', 'Token is null');
      return;
    }

    final requestBody = {
  "question_Type": questionType.value,
  "difficulty_level": difficulty.value,
  "what_to_expect": selectedExpectations.toList(),
};

print("The JSON body being sent for fetching question bank: ${jsonEncode(requestBody)}");

    final response = await http.post(
      Uri.parse(
        '${Urls.baseUrl}/interview/genarateQuestionSet_ByAi?questionBank_id=${id.value}',
      ),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );


    print("The status code for the fetching question bank is: ${response.statusCode}");

    debugPrint("The response for question bank is: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final remainingQuestions = data['body']['remainingQuestions'];
      final historyData = data['body']['history'];

      if (remainingQuestions != null) {
        questions.value = List<Map<String, dynamic>>.from(remainingQuestions);
      } else {
        questions.clear();
      }

      if (historyData != null) {
        history.value = List<Map<String, dynamic>>.from(historyData);
      } else {
        history.clear();
        debugPrint("No history found in the response.");
      }
    } else {
      Get.snackbar('Credit Over', 'Please buy more credit');
    }
  } catch (e) {
    if (kDebugMode) {
      print("The exception is $e");
    }
  } finally {
    isLoading.value = false;
  }
}


  var timeLeft = 0.obs;
  Timer? countdownTimer;

  Future<void> startRecording() async {
    if (!cameraController!.value.isInitialized || isRecording.value) return;

    try {
      final directory = await getTemporaryDirectory();
      videoPath =
          '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      await cameraController!.startVideoRecording();
      isRecording.value = true;

      // 🕒 Start countdown
      final currentQuestion = questions[currentQuestionIndex.value];
      timeLeft.value = currentQuestion['time_to_answer'] ?? 180;
      countdownTimer?.cancel();
      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timeLeft.value > 0) {
          timeLeft.value--;
        } else {
          stopRecording();
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to start recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (!isRecording.value) return;

    try {
      countdownTimer?.cancel(); // ⛔ Cancel the timer
      final file = await cameraController!.stopVideoRecording();
      isRecording.value = false;

      final directory = await getTemporaryDirectory();
      final properVideoPath =
          '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      final recordedFile = File(file.path);
      final mp4File = await recordedFile.copy(properVideoPath);

      videoPath = mp4File.path;

      await submitVideo();
    } catch (e) {
      Get.snackbar('Error', 'Failed to stop recording: $e');
    }
  }

  Future<void> submitVideo() async {
    if (videoPath == null) return;

    isLoading.value = true;
    final currentQuestion = questions[currentQuestionIndex.value];
    final isLast = currentQuestionIndex.value == questions.length - 1;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://ai.mockinterview.inprep.ai/in-prep/api/v1/video_process/process-video/',
        ),
      );

      request.fields['qid'] = currentQuestion['_id'];
      request.fields['interview_id'] = interviewId.value;
      request.fields['questionBank_id'] = id.value;
      request.fields['user_id'] = currentQuestion['user_id'];
      request.fields['isSummary'] = 'true';
      request.fields['islast'] = isLast.toString();
      request.fields['question'] = currentQuestion['question'];
      request.files.add(await http.MultipartFile.fromPath('file', videoPath!));

      debugPrint("The uploaded video path: $videoPath");

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${responseBody.body}');

      if (response.statusCode == 200) {
        lastResponse.value = jsonDecode(responseBody.body);
        Get.toNamed(AppRoute.questionWiseFeedback);
      } else {
        Get.snackbar('Error', 'Failed to submit video');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit video: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void nextQuestion() async {
    await submitVideoAnalysis();
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      questionNumber.value = currentQuestionIndex.value + 1;
      Get.toNamed(AppRoute.startInterviewScreen);
    } else {
      fetchSummary();
      Get.to(OverAllFeedback());
    }
  }

  List<Map<String, dynamic>> toImprove = [
    {'title': 'Try to slow your speech slightly to improve clarity.'},
    {'title': 'Use hand gestures that emphasize your points.'},
    {
      'title':
          'Post-interview, enhance your body language. You excelled in eye contact and posture; just keep your arms relaxed and use gestures to highlight your points.',
    },
  ];

  Future<void> submitVideoAnalysis() async {
    isLoading.value = true;

    try {
      EasyLoading.show(status: "Submitting video analysis...");
      String? token = await SharedPreferencesHelper.getAccessToken();
      if (token == null) {
        Get.snackbar('Error', 'Authorization token is missing.');
        return;
      }

      final currentQuestion = questions[currentQuestionIndex.value];
      final isLast = currentQuestionIndex.value == questions.length - 1;

      final videoUrl = lastResponse['video_url'];
      final assessment = lastResponse['assessment'] ?? {};

      final questionBankId = lastResponse['questionBank_id'];
      final questionId = lastResponse['qid'];
      final interviewId = lastResponse['interview_id'];

      debugPrint("The question bank id is: $questionBankId");

      final body = {
        "user_id": currentQuestion['user_id'],
        "interview_id": interviewId,
        "questionBank_id": questionBankId,
        "question_id": questionId,
        "isSummary": false,
        "islast": isLast.toString(),
        "video_url": videoUrl,
        "assessment": {
          "Articulation": {
            "feedback": assessment["Articulation"]?["feedback"] ?? "",
            "score": assessment["Articulation"]?["score"] ?? 0,
          },
          "Behavioural_Cue": {
            "feedback": assessment["Behavioural_Cue"]?["feedback"] ?? "",
            "score": assessment["Behavioural_Cue"]?["score"] ?? 0,
          },
          "Problem_Solving": {
            "feedback": assessment["Problem_Solving"]?["feedback"] ?? "",
            "score": assessment["Problem_Solving"]?["score"] ?? 0,
          },
          "Inprep_Score": {
            "total_score": assessment["Inprep_Score"]?["total_score"] ?? 0,
          },
          "what_can_i_do_better": {
            "overall_feedback":
                assessment["what_can_i_do_better"]?["overall_feedback"] ?? "",
          },
          "Content_Score": assessment["Content_Score"] ?? 0,
        },
      };

      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/video/submit_Video_Analysis_and_Summary'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(body),
      );

      if (kDebugMode) {
        print("The submitted video analysis response: ${response.body}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Submitted video analysis successfully");
        if (kDebugMode) {
          print('Video analysis submitted successfully');
        }
      } else {
        Get.snackbar('Error', 'Failed to submit video analysis');
        if (kDebugMode) {
          print('Response: ${response.body}');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception occurred: $e');
      if (kDebugMode) {
        print('Exception: $e');
      }
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  var summary = Rxn<SummaryModel>();
  Future<void> fetchSummary() async {
    try {
      isLoading.value = true;
      String? token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse(
          '${Urls.baseUrl}/video/getSummary?questionBank_id=${id.value}',
        ),
        headers: {'Authorization': token!, 'Content-Type': 'application/json'},
      );

      debugPrint("The summary response body is : ${response.body}");

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        summary.value = SummaryModel.fromJson(jsonBody);
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch summary: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> retakeQuestion() async {
  // 1️⃣  Show a blocking loader as soon as the method is entered
  EasyLoading.show(status: 'Retaking…');

  try {
    // ─── your existing logic ────────────────────────────────────────────────────
    final token = await SharedPreferencesHelper.getAccessToken();
    if (token == null) throw Exception('Token is null');

    final currentQuestion = questions[currentQuestionIndex.value];
    final body = {
      'questionBank_id': lastResponse['questionBank_id'],
      'user_id'       : currentQuestion['user_id'],
      'interview_id'  : lastResponse['interview_id'],
      'question_id'   : lastResponse['qid'],
    };

    final response = await http.post(
      Uri.parse('${Urls.baseUrl}/interview/genarateSingleQuestion_ByAi_for_Retake'),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to retake: ${response.body}');
    }

    final newQuestion = (jsonDecode(response.body)['body'] as Map<String, dynamic>);
    if (newQuestion.isEmpty) throw Exception('Empty question returned');

    questions[currentQuestionIndex.value] = newQuestion;
    // ────────────────────────────────────────────────────────────────────────────

    // 2️⃣  Replace the loader with a green “success” toast
    await EasyLoading.dismiss();
    await EasyLoading.showSuccess('Question retaken!');
    Get.offNamed(AppRoute.startInterviewScreen);
  } catch (e) {
    // 3️⃣  Replace the loader with a red “error” toast
    await EasyLoading.dismiss();
    await EasyLoading.showError(e.toString());
  }
}

}