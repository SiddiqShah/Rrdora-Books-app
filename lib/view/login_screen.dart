import 'package:flutter/material.dart';
import 'package:redora/view/homecreen.dart';
import 'package:redora/view/signup_screen1.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              /// App Logo
              Center(child: Image.asset('assets/images/logo.png')),
              /// Welcome text
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

              /// Email field
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

              /// Password field
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
                child: TextButton(onPressed: () {
                  // navigation
                }, 
                child: Text('Forgot password?',
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  color: Color(0xff1255F1)
                ),
                 )),
              ),

              const SizedBox(height: 30),

              /// Login Button
              CustomButton(
                  text: "Login",
                  backgroundColor: const Color(0xff0A369D),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                  },
                ),
              

              const SizedBox(height: 30),



              /// Signup link
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
            ],
          ),
        ),
      ),
    );
  }
}
