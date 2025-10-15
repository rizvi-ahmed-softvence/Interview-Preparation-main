import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GenaratedAboutMeController extends GetxController {
  TextEditingController aboutme = TextEditingController();

  @override
  void onClose() {
    aboutme.dispose();
    super.onClose();
  }
}