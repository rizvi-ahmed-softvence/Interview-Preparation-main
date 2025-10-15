import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/profile_setup.dart/controller/record_controller.dart';

class RecordFeedback extends StatelessWidget {
  RecordFeedback({super.key});

  final VideoRecordingController videoRecordingController =
      Get.find<VideoRecordingController>();

  @override
  Widget build(BuildContext context) {
    debugPrint("Building RecordFeedback widget...");
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Obx(() {
        debugPrint(
          "Obx triggered, lastResponse.value: ${videoRecordingController.lastResponse.value}",
        );
        final response = videoRecordingController.lastResponse.value;

        if (response == null) {
          debugPrint("Response is null, showing CircularProgressIndicator");
          return const Center(child: CircularProgressIndicator());
        }

        debugPrint("Response is not null, processing data: $response");
        final assessment = response.assessment;
        final articulation = assessment.articulation;
        final behavioural = assessment.behaviouralCue;
        final problemSolving = assessment.problemSolving;
        final inprepScore = assessment.inprepScore.totalScore;
        final summary = assessment.whatCanIDoBetter.overallFeedback;
        final videoUrl = response.videoUrl;

        debugPrint(
          "Assessment: $assessment, Articulation: $articulation, Behavioural: $behavioural, ProblemSolving: $problemSolving, InprepScore: $inprepScore, Summary: $summary, VideoUrl: $videoUrl",
        );

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 20,
              right: 20,
              bottom: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Articulation
                Row(
                  children: [
                    Image.asset(IconPath.speechIcon, width: 40, height: 40),
                    const SizedBox(width: 5),
                    Text(
                      'Articulation',
                      style: getTextStyle(
                        color: const Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  articulation.feedback,
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Behavioural Cue
                Row(
                  children: [
                    Image.asset(IconPath.bodyLanguage, width: 40, height: 40),
                    const SizedBox(width: 5),
                    Text(
                      'Behavioural Cue',
                      style: getTextStyle(
                        color: const Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  behavioural.feedback,
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Problem Solving
                Row(
                  children: [
                    Image.asset(IconPath.speechIcon, width: 40, height: 40),
                    const SizedBox(width: 5),
                    Text(
                      'Problem Solving',
                      style: getTextStyle(
                        color: const Color(0xFF212121),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  problemSolving.feedback,
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF293649),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Inprep Score
                Text(
                  'Inprep Score',
                  style: getTextStyle(
                    color: const Color(0xFF212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  inprepScore.toStringAsFixed(2),
                  style: getTextStyle(
                    color: const Color(0xFF212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),

                // Suggestions
                Text(
                  'Suggestions',
                  style: getTextStyle(
                    color: const Color(0xff6a329f),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  summary,
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    color: const Color(0xFF174D31),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),

                // Video URL display
                if (videoUrl.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Video URL:',
                    style: getTextStyle(
                      color: const Color(0xFF212121),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      debugPrint('Video URL: $videoUrl');
                    },
                    child: Text(
                      videoUrl,
                      style: getTextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    videoRecordingController.updateProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37BB74),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(
                    'Continue',
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
