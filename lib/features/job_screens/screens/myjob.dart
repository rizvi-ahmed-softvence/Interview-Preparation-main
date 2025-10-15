import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/job_screens/controller/jobs_controller.dart';
import 'package:inprep_ai/features/job_screens/screens/job_details.dart';
import 'package:inprep_ai/features/job_screens/screens/new_filter_screen.dart';
import 'package:intl/intl.dart';

class MyJobsScreen extends StatelessWidget {
  final JobsController jobsController = Get.put(JobsController());

  MyJobsScreen({super.key});

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(IconPath.backarrow),
                  ),
                  SizedBox(width: 80),
                  Text(
                    'My Jobs',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: jobsController.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for jobs...',
                        hintStyle: TextStyle(
                          color: Color(0xFFABB7C2),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF6a329f)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF6a329f)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF6a329f)),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(12),
                          child: Image.asset(
                            IconPath.search,
                            width: 20,
                            height: 20,
                            color: Color(0xFF6a329f),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF6a329f).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.white,
                            content: SingleChildScrollView(
                              child: FilterScreen(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.find<JobsController>().applyFilters();
                                  Get.back();
                                },
                                child: Text("Apply"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(IconPath.filter1,color: Color(0xFF6a329f)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final jobs = jobsController.filteredJobs;
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF6a329f).withValues(alpha: 0.01),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(25),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title ?? 'No Title',
                                  style: TextStyle(
                                    color: Color(0xff212121),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  job.company ?? 'No Company',
                                  style: TextStyle(
                                    color: Color(0xffAFAFAF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(IconPath.location),
                                        SizedBox(width: 8),
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            job.location ?? 'No Location',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xff676768),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Image.asset(IconPath.calendar),
                                        SizedBox(width: 2.5),
                                        Text(
                                          formatDate(job.posted ?? ''),
                                          style: TextStyle(
                                            color: Color(0xff676768),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        (job.isApplied ?? false)
                                            ? Colors.green[50]
                                            : Colors.orange[50],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    (job.isApplied ?? false)
                                        ? 'Applied'
                                        : 'Not Applied',
                                    style: TextStyle(
                                      color:
                                          (job.isApplied ?? false)
                                              ? const Color(0xff6a329f)
                                              : const Color(0xFFEF9614),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => JobDetailsScreen(), arguments: job);
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xff6a329f),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
