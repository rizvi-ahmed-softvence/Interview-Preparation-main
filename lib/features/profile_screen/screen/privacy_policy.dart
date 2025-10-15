// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/colors.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: AppColors.primaryColor, // You can customize the app bar color
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(IconPath.backarrow),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: const Color(0xFFF6F6F7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title

              // Effective Date & Last Updated
              _buildDateSection('Effective Date:', 'June 1, 2025'),
              _buildDateSection('Last Updated:', 'June 1, 2025'),

              // Sections of the Privacy Policy
              _buildInfoSection(
                'Introduction',
                'At Inprep.ai, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, share, and protect your data when you use our AI-powered interview preparation platform. By using our services, you agree to the practices described in this policy.',
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Information We Collect',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Personal Information',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'We collect personal information when you: ',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    _buildBulletPoint(
                      'Register (email, name, profile image via Google or direct signup)',
                    ),
                    _buildBulletPoint(
                      'Use the Service (mock interviews, assessments, session logs)',
                    ),
                    _buildBulletPoint('Contact support or provide feedback'),
                    SizedBox(height: 16.0),
                    Text(
                      'Interview & Session Data',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'When using our mock interview tools, we collect: ',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    _buildBulletPoint(
                      'Video/audio recordings (with your camera/mic permission)',
                    ),
                    _buildBulletPoint('Transcripts and interview responses'),
                    _buildBulletPoint(
                      'AI-generated feedback (voice tone, eye contact, pacing, etc.)',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Imported Job Listings',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'If you use our Chrome extension, we may collect job descriptions or postings you import from LinkedIn, Indeed, Glassdoor, etc., to tailor your mock interviews',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Device & Usage Data',
                      style: getTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'We automatically collect: ',
                      style: getTextStyle(fontSize: 14),
                    ),
                    _buildBulletPoint(
                      'Browser type, IP address, operating system',
                    ),
                    _buildBulletPoint('Device identifiers and usage metrics'),
                    _buildBulletPoint('Cookie data (see Cookie Policy)'),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How We Use Your Data',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildBulletPoint('Provide and personalize the Service'),
                    _buildBulletPoint(
                      'Deliver feedback and performance analytics',
                    ),
                    _buildBulletPoint(
                      'Improve our AI models and user experience',
                    ),
                    _buildBulletPoint(
                      'Improve our AI models and user experience',
                    ),
                    _buildBulletPoint(
                      'Send occasional updates or promotional materials (opt-out available)',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sharing & Disclosure',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We do not sell your personal information. We may share data with:',
                      style: TextStyle(fontSize: 16),
                    ),
                    _buildBulletPoint(
                      'Service providers (cloud storage, analytics, support tools) under confidentiality agreements',
                    ),
                    _buildBulletPoint(
                      'Legal authorities if required by law, subpoena, or in defense of our rights',
                    ),
                    _buildBulletPoint(
                      'Aggregated analytics for product development (non-identifiable form)',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cookies & Tracking Technologies',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We use cookies and similar technologies to:',
                      style: getTextStyle(fontSize: 14),
                    ),
                    _buildBulletPoint(
                      'Authenticate users and maintain sessions',
                    ),
                    _buildBulletPoint(
                      'Analyze site usage and improve performance',
                    ),
                    _buildBulletPoint(
                      'Customize content and ads (via Google Analytics, Meta Pixel, etc.)',
                    ),
                    SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                        style: getTextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          TextSpan(
                            text:
                                'You can manage cookie preferences via your browser settings. See our ',
                          ),
                          TextSpan(
                            text: 'Cookie Policy',
                            style: TextStyle(
                              color: Color(0xff6a329f),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () async {
                                    const url =
                                        'https://example.com/cookie-policy'; // Replace with actual URL
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                          ),
                          TextSpan(text: ' for details'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Retention',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We retain your data as long as your account is active or as needed to:',
                      style: getTextStyle(fontSize: 14),
                    ),
                    _buildBulletPoint('Comply with legal obligations'),
                    _buildBulletPoint('Resolve disputes'),
                    _buildBulletPoint('Enforce our agreements'),
                    SizedBox(height: 16.0),
                    Text(
                      'You may delete your account or request deletion of your data by emailing us at: support@inprep.ai',
                      style: getTextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Security',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'We retain your data as long as your account is active or as needed to:',
                      style: getTextStyle(fontSize: 16),
                    ),
                    _buildBulletPoint('Comply with legal obligations'),
                    _buildBulletPoint('Resolve disputes'),
                    _buildBulletPoint('Enforce our agreements'),
                    SizedBox(height: 16.0),
                    Text(
                      'You may delete your account or request deletion of your data by emailing us at: support@inprepai',
                      style: getTextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xffEBF8F1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Color(0xff6a329f)),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              'Please use strong unique password and enable two-factor authentication when available',
                              style: getTextStyle(
                                fontSize: 14,
                                color: Color(0xff6a329f),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xff6a329f).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Rights',
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Depending on your location (e.g., GDPR, CCPA), you may have the right to:',
                      style: getTextStyle(fontSize: 14),
                    ),
                    _buildBulletPoint('Access your personal data'),
                    _buildBulletPoint('Correct or delete data'),
                    _buildBulletPoint('Withdraw consent'),
                    _buildBulletPoint('Port your data to another service'),
                    _buildBulletPoint(
                      'Lodge complaints with regulatory authorities',
                    ),
                    SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                        style: getTextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          TextSpan(text: 'To exercise these rights, contact: '),
                          TextSpan(
                            text: 'support@inprep.ai',
                            style: getTextStyle(color: Color(0xff6a329f)),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () async {
                                    const email =
                                        'mailto:support@inprep.ai'; // Email link
                                    if (await canLaunch(email)) {
                                      await launch(email);
                                    } else {
                                      throw 'Could not launch $email';
                                    }
                                  },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              _buildInfoSection(
                'Children’s Privacy',
                'Our services are not intended for users under the age of 13. We do not knowingly collect data from children.',
              ),
              _buildInfoSection(
                'International Users',
                'If you access our services from outside the U.S., your data may be processed and stored in the U.S. By using the service, you consent to this transfer.',
              ),
              _buildInfoSection(
                'Changes to This Policy',
                'We may update this Privacy Policy periodically. Any changes will be posted here with the updated effective date.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Text(
              text,
              style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create the Date sections (Effective Date, Last Updated)
  Widget _buildDateSection(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title ',
              style: getTextStyle(
                color: const Color(0xFF676768),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: date,
              style: getTextStyle(
                color: const Color(0xFF212121),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create the content sections
  Widget _buildInfoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff6a329f).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getTextStyle(
                  color: const Color(0xFF212121),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                content,
                style: getTextStyle(
                  color: const Color(0xFF3D3D3D),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
