import 'dart:convert';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/services/shared_preferences_helper.dart';
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:inprep_ai/features/home_screen/controller/home_screen_controller.dart';
import 'package:inprep_ai/features/subscription/model/allplan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inprep_ai/routes/app_routes.dart';

class SubscriptionController extends GetxController {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  var plans = <Datum>[].obs;
  var sessionId = ''.obs;
  var isPaymentInProgress = false.obs;

  // Button states per priceId: false = "Get Started", true = "Confirm Payment"
  var buttonStates = <String, RxBool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    try {
      EasyLoading.show(status: 'Loading plans...');
      final response = await http.get(Uri.parse(Urls.allplan));
      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final allplan = Allplan.fromJson(data);
        plans.assignAll(allplan.data);

        // Initialize button states for each plan
        for (var plan in plans) {
          buttonStates[plan.priceId] = false.obs;
        }
      } else {
        EasyLoading.showError('Failed to load plans');
        debugPrint('fetchPlans error: status code ${response.statusCode}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error fetching plans');
      debugPrint('Exception in fetchPlans: $e');
    }
  }

  /// Returns true if payment session created (not free plan), false otherwise.
  Future<bool> createCheckoutSession(String? priceId) async {
    final url = Uri.parse(Urls.checkout);

    // Free plan case - do not toggle button state
    if (priceId == null || priceId.isEmpty) {
      EasyLoading.showSuccess('You are in Free Plan Now');
      Get.toNamed(AppRoute.bottomnavbarview);
      return false;
    }

    try {
      EasyLoading.show(status: "Processing payment...");
      isPaymentInProgress.value = true;

      // Retrieve access token using the SharedPreferencesHelper
      String? accessToken = await SharedPreferencesHelper.getAccessToken();
      debugPrint('Access token: $accessToken');

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError('Authentication required');
        isPaymentInProgress.value = false;
        Get.toNamed(AppRoute.bottomnavbarview);
        return false;
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken,
        },
        body: jsonEncode({'priceId': priceId}),
      );

      debugPrint('createCheckoutSession status: ${response.statusCode}');
      debugPrint('createCheckoutSession body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final checkoutUrlString = data['url'];
        final session = _extractSessionIdFromUrl(checkoutUrlString);
        if (session.isNotEmpty) {
          sessionId.value = session;
          debugPrint('Session ID extracted: $session');
        } else {
          debugPrint('No session ID found in URL');
        }

        final checkoutUrl = Uri.tryParse(checkoutUrlString);
        if (checkoutUrl != null && await canLaunchUrl(checkoutUrl)) {
          await launchUrl(checkoutUrl, mode: LaunchMode.externalApplication);
        } else {
          EasyLoading.showError('Failed to open payment gateway');
          Get.toNamed(AppRoute.bottomnavbarview);
          return false;
        }
        return true;
      } else {
        EasyLoading.showError('Payment session creation failed');
        Get.toNamed(AppRoute.bottomnavbarview);
        return false;
      }
    } catch (e) {
      debugPrint('Exception in createCheckoutSession: $e');
      EasyLoading.showError('An error occurred');
      Get.toNamed(AppRoute.bottomnavbarview);
      return false;
    } finally {
      EasyLoading.dismiss();
      isPaymentInProgress.value = false;
    }
  }

  String _extractSessionIdFromUrl(String url) {
    RegExp regExp = RegExp(r"cs_test_[a-zA-Z0-9]+");
    var match = regExp.firstMatch(url);
    return match?.group(0) ?? '';
  }

  Future<void> verifyPayment() async {
    if (sessionId.value.isEmpty) {
      EasyLoading.showError('No payment session to verify');
      return;
    }
    final String apiUrl = Urls.paymentsave;
    try {
      EasyLoading.show(status: 'Verifying payment...');

      // Retrieve access token using SharedPreferencesHelper
      String? accessToken = await SharedPreferencesHelper.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError('Authentication required');
        return;
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': accessToken, // 'Bearer' prefix added for the token
        },
        body: jsonEncode({"sessionId": sessionId.value}),
      );

      debugPrint('verifyPayment status: ${response.statusCode}');
      debugPrint('verifyPayment body: ${response.body}');

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Payment verified successfully!');
        await homeScreenController.getUser();
        Get.toNamed(AppRoute.bottomnavbarview);
      } else {
        EasyLoading.showError('Payment verification failed');
      }
    } catch (e) {
      debugPrint('Exception in verifyPayment: $e');
      EasyLoading.showError('Error verifying payment');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> handleButtonPress(String priceId) async {
    if (priceId.isEmpty) {
      EasyLoading.showError('Invalid plan selected');
      return;
    }

    final isConfirm = buttonStates[priceId]?.value ?? false;

    if (!isConfirm) {
      bool sessionCreated = await createCheckoutSession(priceId);
      if (sessionCreated) {
        buttonStates[priceId]?.value = true;
      }
      // else do nothing to keep button as "Get Started"
    } else {
      await verifyPayment();
      buttonStates[priceId]?.value = false;
    }
  }
}
