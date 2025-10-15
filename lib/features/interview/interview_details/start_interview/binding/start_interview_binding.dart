// lib/features/interview/interview_details/start_interview/binding/start_interview_binding.dart
import 'package:get/get.dart';
import '../controller/start_interview_controller.dart';

class StartInterviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartInterviewController>(() => StartInterviewController());
  }
}
