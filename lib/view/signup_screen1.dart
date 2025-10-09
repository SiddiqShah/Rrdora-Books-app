import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';
import 'package:redora/widgets/custom_snackbar.dart';
import 'login_screen.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key});

  @override
  State<SignupScreen1> createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid(String p) => p.length >= 8;

  Future<void> _handleSignup() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      CustomSnackbar.show(
        context,
        message: 'Please enter email and password',
        isError: true,
      );
      return;
    }

    if (!_isPasswordValid(password)) {
      CustomSnackbar.show(
        context,
        message: 'Password must be at least 8 characters',
        isError: true,
      );
      return;
    }

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final success = await authViewModel.signUp(email, password);

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Account created successfully! Please login.',
        isError: false,
      );

      // Navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Signup failed',
        isError: true,
      );
    }
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
                          'Create your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 22,
                            color: Color.fromARGB(255, 157, 157, 157),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      const Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextfield(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Enter your email',
                      ),
                      const SizedBox(height: 15),

                      const Text(
                        'Password',
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
                        hintText: 'Enter your password',
                      ),
                      const SizedBox(height: 20),

                      CustomButton(
                        text: 'Sign Up',
                        backgroundColor: const Color(0xff0A369D),
                        textColor: Colors.white,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleSignup,
                      ),

                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    color: Color(0xff0A369D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
