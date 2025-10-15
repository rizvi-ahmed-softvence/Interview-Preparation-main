import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inprep_ai/features/subscription/components/get_started_button.dart';
import 'package:inprep_ai/features/subscription/controller/subscription_controller.dart';
import 'package:inprep_ai/features/subscription/service/stripe_service.dart';

class SubscriptionList extends StatelessWidget {
  SubscriptionList({super.key});
  final SubscriptionController controller = Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 0.05;

    return Expanded(
      child: Obx(() {
        if (controller.plans.isEmpty) {
          // No loading indicator; show empty Container or a message instead
          return SizedBox.shrink();
          // Or to show a message:
          // return Center(child: Text('No plans available.'));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.plans.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final plan = controller.plans[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE0E0E1)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: size,
                    right: size,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name,
                        style: GoogleFonts.poppins(
                          color: Color(0xFF3A4C67),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        plan.description,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          color: Color(0xFF676768),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "\$${plan.priceMonthly.toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              color: Color(0xff6a329f),
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "/${plan.priceLabel}",
                            style: GoogleFonts.poppins(
                              color: Color(0xFF174D31),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "What’s included",
                        style: GoogleFonts.poppins(
                          color: Color(0xFF3A4C67),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      ...plan.features.map(
                        (feature) => Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/check.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: GoogleFonts.poppins(
                                    color: Color(0xFF3A4C67),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GetStartedButton(
                        title: "Get Started",
                        ontap: () {
                          final price = plan.priceMonthly;
                          debugPrint("Price being passed: $price");
                          StripeService.makePayment(price, "usd");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
