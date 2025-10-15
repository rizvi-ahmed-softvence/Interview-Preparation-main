// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:http/http.dart' as http;
// import 'package:camera/camera.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
// import 'package:inprep_ai/core/urls/endpint.dart';
// import 'package:inprep_ai/features/profile_setup.dart/models/vedio_reponse.dart';
// import 'package:path_provider/path_provider.dart';

// class VideoRecordingController extends GetxController {
//   CameraController? cameraController;
//   RxBool isCameraInitialized = false.obs;
//   RxInt countdown = 3.obs;
//   RxBool isCountdownActive = false.obs;
//   RxBool isRecording = false.obs;
//   RxInt remainingSeconds = 120.obs; // 120 seconds timer
//   final int maxVideoDuration = 120; // 120 seconds

//   List<CameraDescription> cameras = [];
//   RxBool isLoading = false.obs; // To show loading state
//   String? videoPath;

//   // Observable variable to store the last response
//   Rx<Vedioresponse?> lastResponse = Rx<Vedioresponse?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     initializeCamera();
//   }

//   // Call this function when you want to make the API request
//   Future<void> updateProfile() async {
//     debugPrint('Starting updateProfile method...');

//     EasyLoading.show(status: 'Updating Profile...');
//     isLoading.value = true;
//     debugPrint('EasyLoading is shown, isLoading set to true.');

//     try {
//       // Retrieve the access token
//       String? accessToken = await SharedPreferencesHelper.getAccessToken();
//       debugPrint(
//         "Access token retrieved from SharedPreferencesHelper: $accessToken",
//       );

//       if (accessToken == null || accessToken.isEmpty) {
//         debugPrint('No access token found or access token is empty.');
//         throw Exception('No access token found in SharedPreferences.');
//       }

//       // Create the form data (similar to FormData in JavaScript)
//       final Map<String, dynamic> data = {'isAboutMeVideoChecked': true};
//       final formData = {
//         'data': json.encode(data), // Convert the data into a JSON string
//       };

//       // Create a multipart request
//       final request = http.MultipartRequest(
//         'PATCH',
//         Uri.parse(Urls.updateProfile),
//       );

//       // Add the form data to the request
//       formData.forEach((key, value) {
//         request.fields[key] = value;
//       });

//       // Add the Authorization header
//       request.headers['Authorization'] = accessToken;

//       // Send the request and get the response
//       final response = await request.send();

//       // Convert the response to string for debugging
//       final responseBody = await response.stream.bytesToString();
//       debugPrint('Response received: ${response.statusCode}');
//       debugPrint('Response body: $responseBody');

//       if (response.statusCode == 200) {
//         EasyLoading.showSuccess('Profile Updated Successfully');
//         debugPrint('Profile updated successfully.');
//         Get.toNamed('/bottomnavbarview');
//       } else {
//         EasyLoading.showError('Failed to update profile');
//         debugPrint(
//           'Failed to update profile. Status Code: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       EasyLoading.showError('Error: $e');
//       debugPrint('Error occurred: $e');
//     } finally {
//       isLoading.value = false; // Set loading to false
//       EasyLoading.dismiss();
//       debugPrint('EasyLoading dismissed, isLoading set to false.');
//     }
//   }

//   Future<void> initializeCamera() async {
//     try {
//       cameras = await availableCameras();
//       final frontCamera = cameras.firstWhere(
//         (camera) => camera.lensDirection == CameraLensDirection.front,
//         orElse: () => cameras.first,
//       );

//       cameraController = CameraController(
//         frontCamera,
//         ResolutionPreset.high,
//         enableAudio: true,
//       );

//       await cameraController!.initialize();
//       isCameraInitialized.value = true;
//     } catch (e) {
//       EasyLoading.showError('Failed to initialize camera: $e');
//     }
//   }

//   Future<void> startCountdownAndRecord() async {
//     if (!isCameraInitialized.value) return;

//     // Start countdown
//     isCountdownActive.value = true;
//     countdown.value = 3;
//     while (countdown.value > 0) {
//       await Future.delayed(const Duration(seconds: 1));
//       countdown.value--;
//     }
//     isCountdownActive.value = false;

//     try {
//       await cameraController!.startVideoRecording();
//       isRecording.value = true;
//       remainingSeconds.value = maxVideoDuration;

//       // Countdown timer for 120 seconds
//       while (remainingSeconds.value > 0 && isRecording.value) {
//         await Future.delayed(const Duration(seconds: 1));
//         remainingSeconds.value--;
//       }

//       if (isRecording.value) {
//         await stopRecording();
//       }
//     } catch (e) {
//       EasyLoading.showError('Failed to start recording: $e');
//       isRecording.value = false;
//     }
//   }

//   Future<String?> stopRecording() async {
//     if (!isRecording.value) return null;

//     try {
//       final XFile videoFile = await cameraController!.stopVideoRecording();
//       isRecording.value = false;

//       final directory = await getApplicationDocumentsDirectory();
//       final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
//       final permanentFilePath = '${directory.path}/$fileName';
//       await videoFile.saveTo(permanentFilePath);

//       videoPath = permanentFilePath; // Store the video path for submission
//       remainingSeconds.value = 120; // Reset timer
//       return permanentFilePath;
//     } catch (e) {
//       EasyLoading.showError('Failed to stop recording: $e');
//       return null;
//     }
//   }

//   // Future<void> submitVideo() async {
//   //   if (videoPath == null) {
//   //     debugPrint("Video path is null, exiting submitVideo");
//   //     EasyLoading.showError("Video path is null, exiting submitVideo");
//   //     return;
//   //   }

//   //   debugPrint("Submitting Video...");
//   //   EasyLoading.show(status: 'Submitting Video...');
//   //   try {
//   //     debugPrint(
//   //       "Creating MultipartRequest for POST to: https://freepik.softvenceomega.com/in-prep/api/v1/video_process/process-video/",
//   //     );
//   //     var request = http.MultipartRequest(
//   //       'POST',
//   //       Uri.parse(
//   //         'https://ai.mockinterview.inprep.ai/in-prep/api/v1/video_process/process-video/',
//   //       ),
//   //     );

//   //     request.fields['qid'] = "no_question_Id";
//   //     request.fields['interview_id'] = "no_interview_id";
//   //     request.fields['questionBank_id'] = "no_questionBank_id";
//   //     request.fields['user_id'] = "no_user_id";
//   //     request.fields['isSummary'] = 'false';
//   //     request.fields['islast'] = "false";
//   //     request.fields['question'] = "tell me about yourself";
//   //     request.fields['expected_answer'] = "aboutMeData";
//   //     request.fields['time_to_answer'] = remainingSeconds.value.toString();

//   //     debugPrint("Adding file from path: $videoPath");
//   //     request.files.add(await http.MultipartFile.fromPath('file', videoPath!));

//   //     debugPrint("Sending request...");
//   //     final response = await request.send();
//   //     debugPrint("Response status code: ${response.statusCode}");
//   //     final responseBody = await http.Response.fromStream(response);
//   //     debugPrint("Response body: ${responseBody.body}");

//   //     if (response.statusCode == 200) {
//   //       debugPrint("Response status is 200, decoding JSON...");
//   //       final decodedResponse = jsonDecode(responseBody.body);
//   //       debugPrint("Decoded response: $decodedResponse");
//   //       Vedioresponse videoResponse = Vedioresponse.fromJson(decodedResponse);

//   //       debugPrint(
//   //         "Updating lastResponse with parsed videoResponse: $videoResponse",
//   //       );
//   //       lastResponse.value = videoResponse;

//   //       debugPrint("Dismissing EasyLoading...");
//   //       EasyLoading.dismiss();
//   //       debugPrint("Before navigation to /recordfeedback...");
//   //       Get.toNamed('/recordfeedback'); // Ensure this line is the last step
//   //       debugPrint("Navigation to /recordfeedback completed.");
//   //     } else {
//   //       debugPrint("Response status is not 200, showing error...");
//   //       EasyLoading.showError('Failed to submit video');
//   //     }
//   //   } catch (e) {
//   //     debugPrint("Exception caught: $e");
//   //     debugPrint("Stack trace: ${StackTrace.current}");
//   //     EasyLoading.dismiss();
//   //     debugPrint("Showing error: Failed to submit video: $e");
//   //     EasyLoading.showError('Failed to submit video: $e');
//   //   }
//   // }

//   Future<void> submitVideo() async {
//     if (videoPath == null) {
//       debugPrint("Video path is null, exiting submitVideo");
//       EasyLoading.showError("Video path is null, exiting submitVideo");
//       return;
//     }

//     debugPrint("Submitting Video...");
//     EasyLoading.show(status: 'Submitting Video...');
//     try {
//       debugPrint(
//         "Creating MultipartRequest for POST to: https://freepik.softvenceomega.com/in-prep/api/v1/video_process/process-video/",
//       );
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//           'https://ai.mockinterview.inprep.ai/in-prep/api/v1/video_process/process-video/',
//         ),
//       );

//       request.fields['qid'] = "no_question_Id";
//       request.fields['interview_id'] = "no_interview_id";
//       request.fields['questionBank_id'] = "no_questionBank_id";
//       request.fields['user_id'] = "no_user_id";
//       request.fields['isSummary'] = 'false';
//       request.fields['islast'] = "false";
//       request.fields['question'] = "tell me about yourself";
//       request.fields['expected_answer'] = "aboutMeData";
//       request.fields['time_to_answer'] = remainingSeconds.value.toString();

//       // Extract filename from the full path
//       final filename = videoPath!.split('/').last;
//       debugPrint("Adding file: $filename");
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'file',
//           videoPath!,
//           filename: filename,
//         ),
//       );

//       debugPrint("Sending request...");
//       final response = await request.send();
//       debugPrint("Response status code: ${response.statusCode}");
//       final responseBody = await http.Response.fromStream(response);
//       debugPrint("Response body: ${responseBody.body}");

//       if (response.statusCode == 200) {
//         debugPrint("Response status is 200, decoding JSON...");
//         final decodedResponse = jsonDecode(responseBody.body);
//         debugPrint("Decoded response: $decodedResponse");
//         Vedioresponse videoResponse = Vedioresponse.fromJson(decodedResponse);

//         debugPrint(
//           "Updating lastResponse with parsed videoResponse: $videoResponse",
//         );
//         lastResponse.value = videoResponse;

//         debugPrint("Dismissing EasyLoading...");
//         EasyLoading.dismiss();
//         debugPrint("Before navigation to /recordfeedback...");
//         Get.toNamed('/recordfeedback'); // Ensure this line is the last step
//         debugPrint("Navigation to /recordfeedback completed.");
//       } else {
//         debugPrint("Response status is not 200, showing error...");
//         EasyLoading.showError('Failed to submit video');
//       }
//     } catch (e) {
//       debugPrint("Exception caught: $e");
//       debugPrint("Stack trace: ${StackTrace.current}");
//       EasyLoading.dismiss();
//       debugPrint("Showing error: Failed to submit video: $e");
//       EasyLoading.showError('Failed to submit video: $e');
//     }
//   }

//   @override
//   void onClose() {
//     cameraController?.dispose();
//     super.onClose();
//   }
// }



import 'dart:convert';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/profile_setup.dart/models/vedio_reponse.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

class VideoRecordingController extends GetxController {
  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  RxInt countdown = 3.obs;
  RxBool isCountdownActive = false.obs;
  RxBool isRecording = false.obs;
  RxInt remainingSeconds = 120.obs; // 120 seconds timer
  final int maxVideoDuration = 120; // 120 seconds

  List<CameraDescription> cameras = [];
  RxBool isLoading = false.obs; // To show loading state
  String? videoPath;

  // Observable variable to store the last response
  Rx<Vedioresponse?> lastResponse = Rx<Vedioresponse?>(null);

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  // Call this function when you want to make the API request
  Future<void> updateProfile() async {
    debugPrint('Starting updateProfile method...');

    EasyLoading.show(status: 'Updating Profile...');
    isLoading.value = true;
    debugPrint('EasyLoading is shown, isLoading set to true.');

    try {
      // Retrieve the access token
      String? accessToken = await SharedPreferencesHelper.getAccessToken();
      debugPrint(
        "Access token retrieved from SharedPreferencesHelper: $accessToken",
      );

      if (accessToken == null || accessToken.isEmpty) {
        debugPrint('No access token found or access token is empty.');
        throw Exception('No access token found in SharedPreferences.');
      }

      // Create the form data (similar to FormData in JavaScript)
      final Map<String, dynamic> data = {'isAboutMeVideoChecked': true};
      final formData = {
        'data': json.encode(data), // Convert the data into a JSON string
      };

      // Create a multipart request
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse(Urls.updateProfile),
      );

      // Add the form data to the request
      formData.forEach((key, value) {
        request.fields[key] = value;
      });

      // Add the Authorization header
      request.headers['Authorization'] = accessToken;

      // Send the request and get the response
      final response = await request.send();

      // Convert the response to string for debugging
      final responseBody = await response.stream.bytesToString();
      debugPrint('Response received: ${response.statusCode}');
      debugPrint('Response body: $responseBody');

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Profile Updated Successfully');
        debugPrint('Profile updated successfully.');
        Get.toNamed('/bottomnavbarview');
      } else {
        EasyLoading.showError('Failed to update profile');
        debugPrint(
          'Failed to update profile. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      debugPrint('Error occurred: $e');
    } finally {
      isLoading.value = false; // Set loading to false
      EasyLoading.dismiss();
      debugPrint('EasyLoading dismissed, isLoading set to false.');
    }
  }

  // Initialize Camera
  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: true,
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      EasyLoading.showError('Failed to initialize camera: $e');
    }
  }

  // Countdown and Recording
  Future<void> startCountdownAndRecord() async {
    if (!isCameraInitialized.value) return;

    // Start countdown
    isCountdownActive.value = true;
    countdown.value = 3;
    while (countdown.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      countdown.value--;
    }
    isCountdownActive.value = false;

    try {
      await cameraController!.startVideoRecording();
      isRecording.value = true;
      remainingSeconds.value = maxVideoDuration;

      // Countdown timer for 120 seconds
      while (remainingSeconds.value > 0 && isRecording.value) {
        await Future.delayed(const Duration(seconds: 1));
        remainingSeconds.value--;
      }

      if (isRecording.value) {
        await stopRecording();
      }
    } catch (e) {
      EasyLoading.showError('Failed to start recording: $e');
      isRecording.value = false;
    }
  }

  // Stop Recording and Save Video
  Future<String?> stopRecording() async {
    if (!isRecording.value) return null;

    try {
      final XFile videoFile = await cameraController!.stopVideoRecording();
      isRecording.value = false;

      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';
      final permanentFilePath = '${directory.path}/$fileName';
      await videoFile.saveTo(permanentFilePath);

      videoPath = permanentFilePath; // Store the video path for submission
      remainingSeconds.value = 120; // Reset timer
      return permanentFilePath;
    } catch (e) {
      EasyLoading.showError('Failed to stop recording: $e');
      return null;
    }
  }

  // Re-encode Video using ffmpeg_kit_flutter
  Future<String?> reencodeVideo(String inputFilePath) async {
    final outputFilePath = '${inputFilePath.replaceAll('.mp4', '_encoded.mp4')}';

    final command = '-i $inputFilePath -c:v libx264 -crf 23 -preset fast -c:a aac -strict experimental $outputFilePath';
    final session = await FFmpegKit.execute(command);

    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return outputFilePath; // Return the path to the newly encoded video
    } else {
      debugPrint("Error encoding video: ${session.getFailStackTrace()}");
      return null;
    }
  }

  // Submit Video
  Future<void> submitVideo() async {
    if (videoPath == null) {
      debugPrint("Video path is null, exiting submitVideo");
      EasyLoading.showError("Video path is null, exiting submitVideo");
      return;
    }

    debugPrint("Re-encoding Video...");
    EasyLoading.show(status: 'Re-encoding Video...');
    
    // Re-encode the video before uploading
    String? encodedVideoPath = await reencodeVideo(videoPath!);

    if (encodedVideoPath == null) {
      EasyLoading.showError("Failed to re-encode video.");
      return;
    }

    debugPrint("Re-encoding completed, encoded video path: $encodedVideoPath");

    try {
      debugPrint(
        "Creating MultipartRequest for POST to: https://freepik.softvenceomega.com/in-prep/api/v1/video_process/process-video/",
      );
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://ai.mockinterview.inprep.ai/in-prep/api/v1/video_process/process-video/',
        ),
      );

      request.fields['qid'] = "no_question_Id";
      request.fields['interview_id'] = "no_interview_id";
      request.fields['questionBank_id'] = "no_questionBank_id";
      request.fields['user_id'] = "no_user_id";
      request.fields['isSummary'] = 'false';
      request.fields['islast'] = "false";
      request.fields['question'] = "tell me about yourself";
      request.fields['expected_answer'] = "aboutMeData";
      request.fields['time_to_answer'] = "120";  // Use remainingSeconds value here if needed

      // Extract filename from the full path
      final filename = encodedVideoPath.split('/').last;
      debugPrint("Adding file: $filename");
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          encodedVideoPath,
          filename: filename,
        ),
      );

      debugPrint("Sending request...");
      final response = await request.send();
      debugPrint("Response status code: ${response.statusCode}");
      final responseBody = await http.Response.fromStream(response);
      debugPrint("Response body: ${responseBody.body}");

      if (response.statusCode == 200) {
        debugPrint("Response status is 200, decoding JSON...");
        final decodedResponse = jsonDecode(responseBody.body);
        debugPrint("Decoded response: $decodedResponse");
        Vedioresponse videoResponse = Vedioresponse.fromJson(decodedResponse);

        debugPrint(
          "Updating lastResponse with parsed videoResponse: $videoResponse",
        );
        lastResponse.value = videoResponse;

        debugPrint("Dismissing EasyLoading...");
        EasyLoading.dismiss();
        debugPrint("Before navigation to /recordfeedback...");
        Get.toNamed('/recordfeedback'); // Ensure this line is the last step
        debugPrint("Navigation to /recordfeedback completed.");
      } else {
        debugPrint("Response status is not 200, showing error...");
        EasyLoading.showError('Failed to submit video');
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
      EasyLoading.dismiss();
      debugPrint("Showing error: Failed to submit video: $e");
      EasyLoading.showError('Failed to submit video: $e');
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
