// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/features/profile_screen/controller/terms_controller.dart';

class Termscondition extends StatelessWidget {
  Termscondition({super.key});

  final TermsController controller = Get.put(TermsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        
        title: Text('Terms & Conditions'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Color(0xFFF6F6F7),
          child: Column(
            children: [
              buildTermsSection(
                'Acceptance of Terms',
                'By accessing or using Inprep.ai (“Service”), you agree to these Terms of Use and our Privacy Policy.',
              ),
              buildTermsSection(
                'Eligibility',
                'You must be 13+ (or older if required by local law) and capable of consenting to the Terms. Minors must have parental consent.',
              ),
              buildTermsSection(
                'Account Registration',
                'To use full features, you’ll need to register an account via email or Google. Keep your login details secure and notify us immediately if compromised.',
              ),
              buildTermsSection(
                'Service Description',
                'Inprep provides unlimited AI powered mock interviews and feedback (covering content, body language, vocal delivery) to help improve your interview skills and confidence.',
              ),
              buildTermsSection(
                'Third Party Integrations',
                'The Service allows importing job postings from platforms like LinkedIn, Indeed, Glassdoor, ZipRecruiter, and Monster through our Chrome extension. Use of these platforms is subject to their respective terms.',
              ),
              buildTermsSection(
                'User Content & License',
                'You’re responsible for all data (videos, responses, usage data) you provide. You grant Inprep a worldwide license to process, analyze, and store this data to deliver feedback and improve the service.',
              ),
              buildTermsSection(
                'Privacy & Cookies',
                'Our Cookie Policy covers use of cookies and related tracking. See the Privacy Policy for details on data collection, storage, and your rights.',
              ),
              buildTermsSection(
                'Paid Features & Subscription',
                'Some premium content (e.g. advanced feedback levels) may be behind a paywall. Pricing and trials are as shown in-app or on the site. Subscriptions auto-renew and can be canceled anytime.',
              ),
              buildTermsSection(
                'Prohibited Use',
                'Don’t misuse the Service (e.g., attempt unauthorized access, harass others, upload offensive content). Inprep reserves the right to suspend or terminate accounts that violate these terms.',
              ),
              buildTermsSection(
                'Disclaimer & Limitation of Liability',
                'Inprep provides "as is" interview preparation and AI feedback. We make no guarantees around job outcomes. Use at your own risk.',
              ),
              buildTermsSection(
                'Intellectual Property',
                'All content, trademarks, and software offered by Inprep are the company’s property. Users may not copy, modify, distribute, or create derivatives without permission.',
              ),
              buildTermsSection(
                'Modifications to Terms',
                'We may update these Terms as needed. We’ll notify you (e.g., email, in-app) prior to changes taking effect. Continued use implies acceptance.',
              ),
              buildTermsSection(
                'Termination',
                'You may delete your account anytime. Inprep may also suspend or delete accounts violating these Terms or inactive for extended periods.',
              ),
              buildTermsSection(
                'Governing Law & Disputes',
                'These Terms are governed by the laws of Delaware. Any legal disputes shall be handled in the state or federal courts in Delaware.',
              ),
              buildContactUsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTermsSection(String title, String description) {
    return Obx(() {
      // Check if this section is expanded or not
      bool isVisible = controller.sectionVisibility[title]?.value ?? false;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Color(0xFF6a329f).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF212121),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isVisible
                        ? Icons.arrow_drop_up_outlined
                        : Icons.arrow_drop_down_outlined,
                    color: Colors.black.withValues(alpha:  0.4),
                    size: 24,
                  ),
                  onPressed: () => controller.toggleVisibility(title),
                ),
              ],
            ),
            if (isVisible) ...[
              SizedBox(height: 8),
              Text(
                description,
                style: getTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3D3D3D),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget buildContactUsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff6a329f).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Us',
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF212121),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Address: ',
                  style: getTextStyle(fontSize: 14, color: Color(0xFF676768)),
                ),
                TextSpan(
                  text: '13010 Morris Road, Suite 670, Alpharetta, GA, 30004',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF212121),
                  ),
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: 'Email: ',
                  style: getTextStyle(fontSize: 14, color: Color(0xFF676768)),
                ),
                TextSpan(
                  text: 'Support@inprep.ai',
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6a329f),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
