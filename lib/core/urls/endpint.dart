class Urls {
  static const String baseUrl =
      'https://interview.api.softvenceomega.com/api/v1';
  static const String register = '$baseUrl/users/createUser';
  static const String getuser = '$baseUrl/users/getProfile';
  static const String updateProfile = '$baseUrl/users/updateProfile';
  static const String verifyOtp = '$baseUrl/auth/otpcrossCheck';
  static const String resendOtp = '$baseUrl/auth/reSend_OTP';
  static const String sendOtp = '$baseUrl/auth/send_OTP';
  static const String login = '$baseUrl/auth/login';
  static const String forgetPassword = '$baseUrl/auth/forgetPassword';
  static const String resumeupload = '$baseUrl/resume/upload-resume';
  static const String updateresume = '$baseUrl/resume/update-resume';
  static const String changepassword = '$baseUrl/auth/resetPassword';
  static const String getAllSkills = '$baseUrl/skill/all-skills';
  static const String graph = '$baseUrl/graph/average-data';
  static const String allplan = '$baseUrl/plan/all-plans';
  static const String alljob = '$baseUrl/job/applied-job';
  static const String checkout = '$baseUrl/payment/create-checkout-session';
  static const String paymentsave = '$baseUrl/payment/save-payment';
  static const String allnotification = '$baseUrl/notifications/getAllNotifications';
  static const String notification = '$baseUrl/notifications/getNotificationForNotificationBell';
  static const String fcmToken = '$baseUrl/users/setFCMToken';
  static const String singlequestion = '$baseUrl/interview/genarateSingleQuestion_ByAi_for_Retake';
}
