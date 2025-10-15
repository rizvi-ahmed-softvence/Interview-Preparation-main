import 'package:get/get.dart';

class TermsController extends GetxController {
  // Observable map to track visibility for each section
  var sectionVisibility = <String, RxBool>{}.obs;

  // Method to toggle the visibility of a section
  void toggleVisibility(String section) {
    if (sectionVisibility.containsKey(section)) {
      sectionVisibility[section]?.toggle();
    } else {
      sectionVisibility[section] = false.obs;
    }
  }
}