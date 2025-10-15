// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/core/utils/constants/image_path.dart';
import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
import 'package:inprep_ai/features/interview/interview_lists/view/interview_list_view.dart';
import 'package:inprep_ai/features/notification/screen/notification_screen.dart';
import 'package:inprep_ai/features/notification/widgets/notification_badge.dart';
import 'package:inprep_ai/features/progress_screen/controller/Progress_screen_controller.dart';
import 'package:inprep_ai/features/progress_screen/widgets/line_chart.dart';
import 'package:inprep_ai/features/progress_screen/widgets/placeholder_chart.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  ProgressScreenController progressScreenController = Get.put(
    ProgressScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, top: 5),
          child: Obx(() {
            final imgUrl = homeScreenController.userInfo.value?.data?.img ?? '';
            if (imgUrl.isNotEmpty) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  imgUrl,
                  height: 30,
                  width: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      IconPath.homeprofile,
                      height: 30,
                      width: 48,
                    );
                  },
                ),
              );
            } else {
              return Image.asset(IconPath.homeprofile, height: 48, width: 48);
            }
          }),
        ),
        title: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Welcome Back",
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff676768),
                ),
              ),
            ),
            Obx(() {
              if (homeScreenController.isLoadingUser.value) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Loading...",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                );
              } else {
                final name =
                    homeScreenController.userInfo.value?.data?.name ??
                    "Nolan Saris";
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff212121),
                    ),
                  ),
                );
              }
            }),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Reset the notification count when the user taps on the notification icon
              homeScreenController.resetNotificationCount();

              // Navigate to the NotificationScreen
              Get.to(() => NotificationScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Obx(() {
                final stats = homeScreenController.notificationResponse.value;
                final newCount = stats?.data.newNotification ?? 0;

                return NotificationBadge(
                  count: newCount,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xffE0E0E1),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.notifications_active_rounded,
                      size: 24,
                      color: const Color(0xff3A4C67),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "   Ready to Land \nYour Dream Job?",
                  style: getTextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff212121),
                    lineHeight: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Image.asset(ImagePath.interview, height: 200, width: 200),
              GestureDetector(
                onTap: () {
                  Get.to(InterviewListView());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.933,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: const Color(0xff6a329f),
                        color: const Color(0xff6a329f),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Mock Interview",
                            style: getTextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(IconPath.pause, height: 14, width: 11),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              // CustomButton1(
              //   title: "View Jobs",
              //   onPress: () {
              //     Get.to(MyJobsScreen());
              //   },
              //   backgroundColor: Colors.transparent,
              //   borderColor: Color(0xff6a329f),
              //   textcolor: Color(0xff6a329f),
              // ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Interview Progress",
                  style: getTextStyle(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                final progress = progressScreenController.progress.value;
                if (progress == null ||
                    progress.weeklyOverallAverages.isEmpty) {
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

              SizedBox(height: 48),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Key Features",
                  style: getTextStyle(
                    color: const Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 171,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(ImagePath.yellowframe),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(IconPath.chatbot, height: 47, width: 47),
                      SizedBox(height: 10),
                      Text(
                        "AI-Powered Feedback",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff293649),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Instant analysis of answers, body language, \nand tone.",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3A4C67),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 171,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(ImagePath.greenframe),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(IconPath.manicon, height: 47, width: 47),
                      SizedBox(height: 10),
                      Text(
                        "Personalized Practice",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff293649),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Tailored questions for job-specific \npreparation.",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3A4C67),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 171,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: AssetImage(ImagePath.blueframe),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(IconPath.greenicon, height: 47, width: 47),
                      SizedBox(height: 10),
                      Text(
                        "Unlimited Practice",
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff293649),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Access to a wide range of mock interview \nquestions for continuous improvement.",
                        style: getTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff3A4C67),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.width * 0.28),
            ],
          ),
        ),
      ),
    );
  }
}
