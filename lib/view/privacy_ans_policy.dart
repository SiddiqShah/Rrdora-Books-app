import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins-Bold'),
        ),
        backgroundColor: const Color(0xff0F1030),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Updated: October 2025",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 20),
            Text(
              "1. Introduction",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Welcome to Redora! Your privacy is important to us. "
              "This Privacy Policy explains how we collect, use, and protect your information when you use our app.",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "2. Information We Collect",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "- Personal information such as your email and name when you sign up.\n"
              "- Anonymous usage data such as books viewed, reading progress, and preferences.\n"
              "- Device information (for app performance and analytics).",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "3. How We Use Your Information",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "- To personalize your reading experience.\n"
              "- To provide authentication and secure access.\n"
              "- To improve app performance and recommend content.\n"
              "- To send optional updates or notifications.",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "4. Sharing and Security",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "We do not sell your data. Your information is stored securely using Firebase Authentication and Google Cloud standards. "
              "We may share limited data with trusted providers (like Firebase, Google, and Facebook) for login and analytics purposes.",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "5. Third-Party Services",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Our app uses third-party libraries such as:\n"
              "- Firebase (for authentication and security)\n"
              "- Google Books API (for fetching book data)\n"
              "- WebView (for online book previews)\n\n"
              "These services have their own privacy policies that apply in addition to ours.",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "6. Your Rights",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "You can:\n"
              "- Request deletion of your account and data.\n"
              "- Opt-out of marketing emails.\n"
              "- Access or update your personal information.",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "7. Contact Us",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Bold',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "If you have questions about this policy, contact us at:\n"
              "@ siddiqsh004@gmail.com",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
