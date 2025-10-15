// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/progress_screen/widgets/grid_chart.dart';
import 'package:inprep_ai/features/progress_screen/widgets/line_chart.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/progress_screen/controller/Progress_screen_controller.dart';
import 'package:inprep_ai/features/progress_screen/widgets/placeholder_chart.dart';
import 'package:inprep_ai/features/progress_screen/widgets/placeholder_card.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  ProgressScreenController progressScreenController = Get.put(
    ProgressScreenController(),
  );

  // Function to generate PDF
  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    // Get data from controller
    final progressData = progressScreenController.progress.value;

    if (progressData != null) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            // Center the content in the middle of the page
            return pw.Center(
              child: pw.Column(
                mainAxisSize:
                    pw.MainAxisSize.min, // Only take the required space
                children: [
                  pw.Text(
                    'Progress Report',
                    style: pw.TextStyle(
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text('Total Interviews: ${progressData.totalInterviews}',style: pw.TextStyle(
                    fontSize: 18,
                  )),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Interview Progress:',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Content Accuracy: ${progressData.totalAverage.contentScore}%',
                    style: pw.TextStyle(
                    fontSize: 18,
                  )
                  ),
                  pw.Text(
                    'Behavioural Cue: ${progressData.totalAverage.behaviouralCue}%',
                    style: pw.TextStyle(
                    fontSize: 18,
                  )
                  ),
                  pw.Text(
                    'Articulation Clarity: ${progressData.totalAverage.articulation}%',
                    style: pw.TextStyle(
                    fontSize: 18,
                  )
                  ),
                  pw.Text(
                    'Inprep Score: ${progressData.totalAverage.inprepScore}%',
                    style: pw.TextStyle(
                    fontSize: 18,
                  )
                  ),
                  pw.Text(
                    'Problem Solving: ${progressData.totalAverage.problemSolving}%',
                    style: pw.TextStyle(
                    fontSize: 18,
                  )
                  ),
                ],
              ),
            );
          },
        ),
      );

      // Get the temporary directory path to store the PDF
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/progress_report.pdf';

      // Save the PDF to the directory
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Open the PDF file using open_file package
      OpenFile.open(
        filePath,
      ); // This will open the PDF on both iOS and Android devices
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Progress & Insights",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff212121),
                          ),
                        ),
                        SizedBox(height: 15),
                        Obx(
                          () => Text(
                            progressScreenController
                                    .progress
                                    .value
                                    ?.totalInterviews
                                    .toString() ??
                                "0",
                            style: TextStyle(
                              color: const Color(0xff6a329f),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Total Interviews",
                          style: TextStyle(
                            color: Color(0xff878788),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Interview Progress",
                    style: TextStyle(
                      color: Color(0xff212121),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    final progress = progressScreenController.progress.value;
                    if (progress == null || progress.weeklyOverallAverages.isEmpty) {
                      // Show static chart when no data is available (all values as 0)
                      return const PlaceholderChart();
                    }

                    return SizedBox(
                      height: 152,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: LineChartPainter(
                          data: progress.weeklyOverallAverages,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 45),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 16,
                      children: List.generate(5, (index) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount:
                              index == 4
                                  ? 2
                                  : 1, // Make the last item take full width
                          mainAxisCellCount: 1,
                          child: Obx(() {
                            final progressData =
                                progressScreenController.progress.value;

                            if (progressData == null) {
                              return const PlaceholderCard(index: 0); // Placeholder Card with 0 values
                            }

                            return CardWidget(
                              index: index,
                              progress: progressData,
                            );
                          }),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      generatePDF(
                        context,
                      ); // Call the function to generate and download the PDF
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff6a329f),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Download Progress Report",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.download_for_offline_rounded,
                                size: 24,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
