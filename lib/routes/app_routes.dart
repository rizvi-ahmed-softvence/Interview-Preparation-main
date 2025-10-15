import 'package:get/get.dart';
import 'package:inprep_ai/features/authentication/screen/login_otp_send_screen.dart';
import 'package:inprep_ai/features/authentication/screen/login_screen.dart';
import 'package:inprep_ai/features/authentication/screen/otp_sent_screen.dart';
import 'package:inprep_ai/features/authentication/screen/signup_screen.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/binding/start_interview_binding.dart'
    show StartInterviewBinding;
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/question_wise_feedback.dart'
    show QuestionWiseFeedback;
import 'package:inprep_ai/features/interview/interview_details/start_interview/view/start_interview_view.dart'
    show StartInterviewView;
import 'package:inprep_ai/features/job_screens/screens/myjob.dart';
import 'package:inprep_ai/features/navigationbar/screen/navigationbar_screen.dart';
import 'package:inprep_ai/features/notification/screen/notification_screen.dart';
import 'package:inprep_ai/features/profile_screen/screen/privacy_policy.dart';
import 'package:inprep_ai/features/profile_screen/screen/terms&condition.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/genarated_about_me.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/profile_slider.dart';
import 'package:inprep_ai/features/profile_setup.dart/screen.dart/record_feedback.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash1_screen.dart';
import 'package:inprep_ai/features/splash_screen/screen/splash_screen.dart';
import '../features/authentication/screen/change_password.dart'
    show ChangePassword;

class AppRoute {
  static String loginScreen = "/loginScreen";
  static String signupScreen = "/signupScreen";
  static String otpSentScreen = "/otpSentScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";
  static String otpSentScreen2 = "/otpSentScreen2";
  static String changePassword = "/changePassword";
  static String splashscreen = "/splashscreen";
  static String splash1Screen1 = "/splash1Screen1";
  static String profileslider = "/profileslider";
  static String myJobsScreen = "/myJobsScreen";
  static String bottomnavbarview = "/bottomnavbarview";
  static String loginOtpSendScreen = "/loginOtpSendScreen";
  static String genaratedaboutme = "/genaratedaboutme";
  static String notificationscreen = "/notificationscreen";
  static String startInterviewScreen = "/startInterviewScreen";
  static String questionWiseFeedback = "/questionWiseFeedback";
  static String recordfeedback = "/recordfeedback";
  static String privacypolicy = "/privacypolicy";
  static String termscondition = "/termscondition";

  static String getLoginScreen() => loginScreen;
  static String getSignupScreen() => signupScreen;
  static String getOtpSentScreen() => otpSentScreen;
  static String getForgotPasswordScreen() => forgotPasswordScreen;
  static String getOtpSentScreen2() => otpSentScreen2;
  static String getChangePassword() => changePassword;
  static String getsplashscreen() => splashscreen;
  static String getsplash1Screen1() => splash1Screen1;
  static String getmyJobsScreen() => myJobsScreen;
  static String getprofileslider() => profileslider;
  static String getbottomnavbarview() => bottomnavbarview;
  static String getloginOtpSendScreen() => loginOtpSendScreen;
  static String getgenaratedaboutme() => genaratedaboutme;
  static String getnotificationscreen() => notificationscreen;
  static String getStartInterviewScreen() => startInterviewScreen;
  static String getrecordfeedback() => recordfeedback;
  static String getprivacypolicy() => privacypolicy;
  static String gettermscondition() => termscondition;

  static List<GetPage> routes = [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: changePassword, page: () => ChangePassword()),
    GetPage(name: splashscreen, page: () => SplashScreen()),
    GetPage(name: splash1Screen1, page: () => Splash1Screen1()),
    GetPage(name: myJobsScreen, page: () => MyJobsScreen()),
    GetPage(name: profileslider, page: () => ProfileSlider()),
    GetPage(name: otpSentScreen, page: () => OTPScreen()),
    GetPage(name: bottomnavbarview, page: () => BottomNavbarView()),
    GetPage(name: loginOtpSendScreen, page: () => LoginOtpSendScreen()),
    GetPage(name: genaratedaboutme, page: () => GenaratedAboutMe()),
    GetPage(name: notificationscreen, page: () => NotificationScreen()),
    GetPage(name: recordfeedback, page: () => RecordFeedback()),
    GetPage(name: privacypolicy, page: () => PrivacyPolicy()),
    GetPage(name: termscondition, page: () => Termscondition()),

    /// ✅ StartInterview Screen with Binding
    GetPage(
      name: startInterviewScreen,
      page: () => StartInterviewView(),
      binding: StartInterviewBinding(),
    ),

    GetPage(
      name: questionWiseFeedback,
      page: () => QuestionWiseFeedback(),
      binding: StartInterviewBinding(), // ✅ Add this line
    ),
  ];
}
