import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inprep_ai/app.dart';
import 'package:inprep_ai/firebase_service.dart';
import 'package:inprep_ai/features/subscription/service/stripe_service.dart' show StripeService;
import 'package:inprep_ai/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Add this

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  // Initialize Stripe (will now use keys from .env)
  await StripeService.init();

  runApp(const Inprepai());
}
