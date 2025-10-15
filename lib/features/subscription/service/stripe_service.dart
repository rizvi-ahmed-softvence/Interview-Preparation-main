import 'dart:convert';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

class StripeService {
  /// Initialize Stripe with publishable key from .env
  static Future<void> init() async {
    Stripe.publishableKey = dotenv.env['PUBLISHABLE_KEY'] ?? '';
    await Stripe.instance.applySettings();
  }

  /// Make a payment
  static Future<void> makePayment(double amount, String currency) async {
    try {
      final int amountInCents = (amount * 100).toInt();
      final paymentIntent = await _createPaymentIntent(amountInCents, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Your App Name',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      if (kDebugMode) {
        print('\$$amount payment successful');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Payment error: $e');
      }
    }
  }

  /// Create payment intent using secret key from .env
  static Future<Map<String, dynamic>> _createPaymentIntent(int amount, String currency) async {
    try {
      final secretKey = dotenv.env['SECRET_KEY'] ?? '';

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount.toString(),
          'currency': currency,
        },
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception('Failed to create payment intent: $err');
    }
  }
}
