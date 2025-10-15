import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/splash_screen/controller/splash_controller.dart';
import '../../../core/utils/constants/icon_path.dart' show IconPath;

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());

    return CupertinoPageScaffold(
  child: Container(
    decoration: BoxDecoration(
      gradient: AppColors.splashlinearGradient,
    ),
    child: Center(child: Image.asset(IconPath.splash, width: double.infinity)),
  ),
);
  }
}
