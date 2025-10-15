import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inprep_ai/app.dart';
import 'package:inprep_ai/firebase_service.dart';
import 'package:inprep_ai/features/subscription/service/stripe_service.dart' show StripeService;
import 'package:inprep_ai/firebase_options.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  runApp(
    const Inprepai());
   await StripeService.init();
}
