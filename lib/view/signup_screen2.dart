import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:redora/view/onboarding_screen.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';

class SignupScreen2 extends StatefulWidget {
  const SignupScreen2({super.key});

  @override
  State<SignupScreen2> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  final TextEditingController passwordController = TextEditingController();

  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = passwordController.text;
    setState(() {
      hasMinLength = password.length >= 8;
      hasUppercase = password.contains(RegExp(r'[A-Z]'));
      hasLowercase = password.contains(RegExp(r'[a-z]'));
      hasSpecialChar = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
    });
  }

  Widget _buildRequirement(String text, bool condition) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 75),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Poppins-Bold',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'Select strong password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins-Medium',
                    fontSize: 18,
                    color: Color.fromARGB(255, 157, 157, 157),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Password",
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextfield(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                hintText: "Enter your password",
              ),
              const SizedBox(height: 15),

              // 🔥 Password Rules
              _buildRequirement("At least 8 characters", hasMinLength),
              _buildRequirement("At least 1 uppercase letter", hasUppercase),
              _buildRequirement("At least 1 lowercase letter", hasLowercase),
              _buildRequirement("At least 1 special character", hasSpecialChar),

              SizedBox(height: 20,),

              CustomButton(
                  text: "Continue",
                  backgroundColor: const Color(0xff0A369D),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
                  },
                ),
            SizedBox(height: 10,),
             RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 15,
                  color: Colors.white,
                ),
                children: [
                  const TextSpan(
                    text: 'By creating an account, you agree to the ',
                  ),
                  TextSpan(
                    text: 'Terms of Services ',
                    style: const TextStyle(
                      color: Color(0xff1255F1), // Blue link color
                      decoration: TextDecoration.underline,
                    ),
                    // Add tap functionality
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: navigate to Terms page
                      },
                  ),
                  const TextSpan(
                    text: 'and ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                      color: Color(0xff1255F1),
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: navigate to Privacy Policy page
                      },
                  ),
                ],
              ),
            ),

            ],
          ),
        ),
      ),
    );
  }
}
