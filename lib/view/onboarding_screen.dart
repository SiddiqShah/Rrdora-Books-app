import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final int totalPages = 6; // adjust to your total steps

  void nextPage() {
    if (currentPage < totalPages - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLast() {
    _controller.jumpToPage(totalPages - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 75),
        child: Column(
          children: [
            // 🔹 Progress bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: (currentPage + 1) / totalPages,
                minHeight: 5,
                valueColor: const AlwaysStoppedAnimation(Color(0xff1255F1)),
                backgroundColor: Colors.white24,
              ),
            ),
        
            // 🔹 PageView with all steps
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(), // lock swipe
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                children: [
                  // WelcomeScreen(onContinue: nextPage, onSkip: skipToLast),
                  // UserInfoScreen(onContinue: nextPage),
                  // PurposeScreen(onContinue: nextPage),
                  // InterestScreen(onContinue: nextPage),
                  // ReminderScreen(onContinue: nextPage),
                  // SubscriptionScreen(), // last step
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
