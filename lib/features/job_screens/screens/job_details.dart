import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/controllers/job_details_controller.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/job_screens/models/all_jobs_model.dart';
import 'package:intl/intl.dart'; // Import your model

class JobDetailsScreen extends StatelessWidget {
  final JobDetailsController controller = Get.put(JobDetailsController());

  JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the job data passed from MyJobsScreen
    final AllJobsModel job = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 8),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     job.title ?? 'No Title',  // Display job title
                  //     style: getTextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 24,
                  //       color: Color(0xff212121),
                  //     ),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 300,
                      ), // You can adjust this value as per your design
                      child: Text(
                        job.title ?? 'No Title', // Display job title
                        style: getTextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(0xff212121),
                        ),
                        overflow:
                            TextOverflow
                                .ellipsis, // Ensures text truncates with ellipsis if it overflows
                        maxLines: 3, // Allows the text to span up to 3 lines
                        softWrap:
                            true, // Ensures that the text wraps onto new lines when necessary
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow(
                      'Company',
                      job.company ?? 'No Company', // Display company
                      Color(0xff6a329f),
                    ),
                    buildInfoRow(
                      'Location',
                      job.location ?? 'No Location', // Display location
                      Color(0xff6a329f),
                    ),
                    buildInfoRow(
                      // 'Apply Date',
                      'Job Posted',
                      formatDate(job.posted ?? ''), // Display posted date
                      Color(0xff6a329f),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text('Job Description', style: sectionTitleStyle()),
              SizedBox(height: 8),
              Text(
                job.description ??
                    'No Description Available', // Display description
                style: bodyStyle(),
              ),
              SizedBox(height: 24),
              Text('Job Requirements', style: sectionTitleStyle()),
              SizedBox(height: 8),
              Text(
                'Strong coding skills in JavaScript, Python. Knowledge of cloud technologies.',
                style: bodyStyle(),
              ),
              SizedBox(height: 24),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff6a329f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Start Mock Interview',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.play_arrow, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text('Previous Interview Results', style: sectionTitleStyle()),
              SizedBox(height: 8),
              Text('Inprep Score', style: bodyStyle()),
              SizedBox(height: 8),
              Obx(
                () => Text(
                  '${controller.inprepScore}/100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff37BB74),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text('Feedback', style: bodyStyle()),
              SizedBox(height: 4),
              Text(controller.feedback, style: bodyStyle()),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: getTextStyle(
              color: Color(0xff676768),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: getTextStyle(
              color: valueColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle sectionTitleStyle() {
    return getTextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Color(0xff212121),
    );
  }

  TextStyle bodyStyle() {
    return getTextStyle(
      fontSize: 16,
      color: Color(0xff676768),
      fontWeight: FontWeight.w400,
    );
  }

  // Function to format the date in "yyyy-MM-dd"
  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(
        dateString,
      ); // Parse the string to DateTime
      return DateFormat(
        'yyyy-MM-dd',
      ).format(dateTime); // Format it to "yyyy-MM-dd"
    } catch (e) {
      return ''; // Return an empty string if date parsing fails
    }
  }
}
