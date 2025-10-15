// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';


Future<void> handleBacgroundMessage(RemoteMessage message) async {
  // Handle background message
  print("Handling background message: ${message.data}");
  // You can perform any necessary actions here, such as saving the message to a database or displaying a notification
}


class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // Request permission for push notifications
    await _firebaseMessaging.requestPermission();

    // Retrieve the Firebase Cloud Messaging token
    final fCMToken = await _firebaseMessaging.getToken();
    print("Firebase Messaging Token: $fCMToken");

    // Save the FCM token to SharedPreferences
    if (fCMToken != null) {
      await SharedPreferencesHelper.saveFCMToken(fCMToken); // Save token to SharedPreferences
      print("FCM Token saved to SharedPreferences: $fCMToken");
    }
    FirebaseMessaging.onBackgroundMessage(handleBacgroundMessage);
  }
}
