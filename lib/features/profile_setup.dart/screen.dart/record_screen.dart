// // File: lib/features/video_recording_screen.dart
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';
// import 'package:inprep_ai/features/profile_setup.dart/controller/record_controller.dart';

// class VideoRecordingScreen extends StatelessWidget {
//   VideoRecordingScreen({super.key});

//   final VideoRecordingController videoController = Get.put(VideoRecordingController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "Record Interview Video",
//           style: getTextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//             color: const Color(0xff212121),
//           ),
//         ),
//       ),
//       body: Obx(() => Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Camera Preview
//               Expanded(
//                 child: videoController.isCameraInitialized.value
//                     ? Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           CameraPreview(videoController.cameraController!),
//                           // Countdown Overlay
//                           if (videoController.isCountdownActive.value)
//                             Container(
//                               color: Colors.black54,
//                               child: Center(
//                                 child: Text(
//                                   videoController.countdown.value.toString(),
//                                   style: getTextStyle(
//                                     fontSize: 60,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           // Recording Indicator and Timer
//                           if (videoController.isRecording.value)
//                             Positioned(
//                               top: 20,
//                               left: 20,
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 10,
//                                   vertical: 5,
//                                 ),
//                                 color: Colors.red,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "REC",
//                                       style: getTextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Text(
//                                       "${videoController.remainingSeconds.value}s",
//                                       style: getTextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       )
//                     : const Center(child: CircularProgressIndicator()),
//               ),
//               // Control Button
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: ElevatedButton(
//                   onPressed: videoController.isRecording.value
//                       ? () async {
//                           final videoPath = await videoController.stopRecording();
//                           if (videoPath != null) {
//                             Get.back(result: videoPath); // Return video path to previous screen
//                           }
//                         }
//                       : videoController.isCountdownActive.value
//                           ? null
//                           : () {
//                               videoController.startCountdownAndRecord();
//                             },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff6a329f),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: Text(
//                     videoController.isRecording.value
//                         ? "Stop Recording"
//                         : "Start Recording",
//                     style: getTextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//               // Submit Button (visible only after recording stops)
//               if (!videoController.isRecording.value && !videoController.isCountdownActive.value)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       // Placeholder for submit action
//                       Get.snackbar(
//                         'Success',
//                         'Video submitted successfully',
//                         snackPosition: SnackPosition.BOTTOM,
//                       );
//                       Get.back(); // Optionally navigate back or to another screen
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff6a329f),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     child: Text(
//                       "Submit Video",
//                       style: getTextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           )),
//     );
//   }
// }

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/record_controller.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class VideoRecordingScreen extends StatelessWidget {
  VideoRecordingScreen({super.key});

  final VideoRecordingController videoController = Get.put(
    VideoRecordingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Record Interview Video",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xff212121),
          ),
        ),
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Camera Preview
            Expanded(
              child:
                  videoController.isCameraInitialized.value
                      ? Stack(
                        alignment: Alignment.center,
                        children: [
                          CameraPreview(videoController.cameraController!),
                          // Countdown Overlay
                          if (videoController.isCountdownActive.value)
                            Container(
                              color: Colors.black54,
                              child: Center(
                                child: Text(
                                  videoController.countdown.value.toString(),
                                  style: getTextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          // Recording Indicator and Timer
                          if (videoController.isRecording.value)
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Text(
                                      "REC",
                                      style: getTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${videoController.remainingSeconds.value}s",
                                      style: getTextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),
            // Control Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed:
                    videoController.isRecording.value
                        ? () async {
                          final videoPath =
                              await videoController.stopRecording();
                          if (videoPath != null) {
                            // After stopping the recording, show submit button
                            Get.snackbar(
                              'Recording Stopped',
                              'You can now submit the video',
                            );
                          }
                        }
                        : videoController.isCountdownActive.value
                        ? null
                        : () {
                          videoController.startCountdownAndRecord();
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6a329f),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  videoController.isRecording.value
                      ? "Stop Recording"
                      : "Start Recording",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Submit Button (visible only after recording stops)
            if (!videoController.isRecording.value &&
                !videoController.isCountdownActive.value)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    videoController.submitVideo(); // Call the submit function
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff6a329f),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Submit Video",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
