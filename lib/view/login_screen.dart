import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/view/signup_screen1.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';
import 'package:redora/widgets/custom_snackbar.dart';
import 'homecreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showSignupPrompt = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final success = await authViewModel.login(
      emailController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Login successful!',
        isError: false,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        if (authViewModel.errorMessage?.contains("No user found") ?? false) {
          showSignupPrompt = true;
        }
      });
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Login failed',
        isError: true,
      );
    }
  }

  Future<void> _handleGoogleLogin() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final success = await authViewModel.loginWithGoogle();

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Google login successful!',
        isError: false,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Google login failed',
        isError: true,
      );
    }
  }

  Future<void> _handleFacebookLogin() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    final success = await authViewModel.loginWithFacebook();

    if (!mounted) return;

    if (success) {
      CustomSnackbar.show(
        context,
        message: 'Facebook login successful!',
        isError: false,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      CustomSnackbar.show(
        context,
        message: authViewModel.errorMessage ?? 'Facebook login failed',
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
                      Center(child: Image.asset('assets/images/logo.png')),
                      const Center(
                        child: Text(
                          'WELCOME BACK!',
                          style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Center(
                        child: Text(
                          'Track your goals and\nnever miss a day',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14,
                            color: Color.fromARGB(255, 157, 157, 157),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                        keyboardType: TextInputType.text,
                        hintText: "Enter your password",
                        obscureText: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              color: Color(0xff1255F1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        text: "Login",
                        backgroundColor: const Color(0xff0A369D),
                        textColor: Colors.white,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleLogin,
                      ),
                      const SizedBox(height: 20),
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
                            "or continue with",
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
                      const SizedBox(height: 20),
                      CustomButton(
                        icon: FontAwesomeIcons.google,
                        text: 'Continue with Google',
                        backgroundColor: const Color(0xffD9D9D9),
                        textColor: Colors.black,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleGoogleLogin,
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        icon: FontAwesomeIcons.facebook,
                        text: 'Continue with Facebook',
                        backgroundColor: const Color(0xffD9D9D9),
                        textColor: Colors.black,
                        onPressed: authViewModel.isLoading
                            ? null
                            : _handleFacebookLogin,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: 'Poppins-Medium',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen1(),
                                ),
                              );
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                fontFamily: 'Poppins-Bold',
                                fontSize: 14,
                                color: Color(0xff0A369D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      showSignupPrompt
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "No account found for this email. Please sign up first.",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'Poppins-Medium',
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
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
