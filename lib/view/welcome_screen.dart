import 'package:flutter/material.dart';
import 'package:redora/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Title
            Center(
              child: const Text(
                "Welcome to Redora",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 22),

            // Illustration box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/Welcome.png",
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 28),

            RichText(
              textAlign: TextAlign.start,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Your personal ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "library",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            RichText(
              textAlign: TextAlign.start,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Filled with books that spark imagination.\n"
                          "From classics to modern tales, it’s treasure\n"
                          "Where knowledge and wisdom forever rove\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                  TextSpan(
                   text:  "Read more...",
                   style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                ),
                  )
                ],
              ),
            ),

            SizedBox(height: 50,),

            CustomButton(text: 'Continue', 
            backgroundColor: Color(0xff0A369D), 
            textColor: Colors.white,
            onPressed: () {
              // navigation
            },)


            
          ],
        ),
      ),
    );
  }
}
