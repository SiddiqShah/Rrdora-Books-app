import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/view/login_screen.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';
import 'package:redora/widgets/custom_snackbar.dart';

class SignupScreen2 extends StatefulWidget {
  final String email;

  const SignupScreen2({super.key, required this.email});

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

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
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

  bool get isPasswordValid =>
      hasMinLength && hasUppercase && hasLowercase && hasSpecialChar;

  Future<void> _handleSignup() async {
    if (!isPasswordValid) {
      CustomSnackbar.show(
        context,
        message: 'Please meet all password requirements',
        isError: true,
      );
      return;
    }

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final success = await authViewModel.signUp(
      widget.email,
      passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Account created successfully! Please login.',
        isError: false,
      );

      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Signup failed',
        isError: true,
      );
    }
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
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 75,
                ),
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

                      // Display email
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.email, color: Colors.white70),
                            const SizedBox(width: 12),
                            Text(
                              widget.email,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
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

                      // Password Rules
                      _buildRequirement("At least 8 characters", hasMinLength),
                      _buildRequirement(
                        "At least 1 uppercase letter",
                        hasUppercase,
                      ),
                      _buildRequirement(
                        "At least 1 lowercase letter",
                        hasLowercase,
                      ),
                      _buildRequirement(
                        "At least 1 special character",
                        hasSpecialChar,
                      ),

                      const SizedBox(height: 20),

                      CustomButton(
                        text: "Continue",
                        backgroundColor: const Color(0xff0A369D),
                        textColor: Colors.white,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleSignup,
                      ),
                      const SizedBox(height: 10),
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
                                color: Color(0xff1255F1),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // TODO: navigate to Terms page
                                },
                            ),
                            const TextSpan(text: 'and '),
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
              if (authViewModel.isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xff1255F1)),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
