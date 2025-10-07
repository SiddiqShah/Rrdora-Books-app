import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/view/signup_screen2.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';
import 'package:redora/widgets/custom_snackbar.dart';
import 'homecreen.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key});

  @override
  State<SignupScreen1> createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _handleEmailSignup() {
    if (emailController.text.trim().isEmpty) {
      CustomSnackbar.show(
        context,
        message: 'Please enter your email',
        isError: true,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen2(email: emailController.text.trim()),
      ),
    );
  }

  Future<void> _handleGoogleSignup() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final success = await authViewModel.loginWithGoogle();

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Account created successfully!',
        isError: false,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Google signup failed',
        isError: true,
      );
    }
  }

  Future<void> _handleFacebookSignup() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final success = await authViewModel.loginWithFacebook();

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Account created successfully!',
        isError: false,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Facebook signup failed',
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
                      const SizedBox(height: 100),
                      const Text(
                        "Email",
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
                        hintText: "Enter your email",
                      ),
                      const SizedBox(height: 15),
                      CustomButton(
                        text: "Sign Up with Email",
                        backgroundColor: const Color(0xff0A369D),
                        textColor: Colors.white,
                        onPressed: _handleEmailSignup,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Colors.white54,
                              thickness: 1,
                              endIndent: 10,
                            ),
                          ),
                          Text(
                            "or Signup with",
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white54,
                              thickness: 1,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        icon: FontAwesomeIcons.google,
                        text: 'Continue with Google',
                        backgroundColor: const Color(0xffD9D9D9),
                        textColor: Colors.black,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleGoogleSignup,
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        icon: FontAwesomeIcons.apple,
                        text: 'Continue with Apple',
                        backgroundColor: const Color(0xffD9D9D9),
                        textColor: Colors.black,
                        onPressed: () {
                          CustomSnackbar.show(
                            context,
                            message: 'Apple Sign In coming soon!',
                            isError: false,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        icon: FontAwesomeIcons.facebook,
                        text: 'Continue with Facebook',
                        backgroundColor: const Color(0xffD9D9D9),
                        textColor: Colors.black,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleFacebookSignup,
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
