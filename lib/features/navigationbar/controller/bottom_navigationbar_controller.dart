import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/home_screen/screen/home_screen.dart';
import 'package:inprep_ai/features/interview/interview_lists/view/interview_list_view.dart';
import 'package:inprep_ai/features/profile_screen/screen/profile_screen.dart';
import 'package:inprep_ai/features/progress_screen/screen/progress_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class BottomNavbarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  Widget getCurrentScreen() {
    switch (selectedIndex.value) {
      case 0:
        return HomeScreen();
      case 1:
        return InterviewListView();
      case 2:
        return ProgressScreen();
      default:
        return ProfileScreen();
    }
  }

  var userType = ''.obs;
  Future<void> getUserType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userType.value = prefs.getString('userType') ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    getUserType();
  }
}
