import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redora/view/signup_screen2.dart';
import 'package:redora/widgets/custom_button.dart';
import 'package:redora/widgets/custom_textfiled.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key});

  @override
  State<SignupScreen1> createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F1030),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 75),
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
                SizedBox(height: 100,),
                const Text(
                "Email",
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              CustomTextfield(controller: emailController),
              SizedBox(height: 15,),
              CustomButton(
                  text: "Sign Up with Email",
                  backgroundColor: const Color(0xff0A369D),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen2()));
                  },
                ),
              SizedBox(height: 30,),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.white54,
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  const Text(
                    "or Signup with",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Expanded(
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
                backgroundColor: Color(0xffD9D9D9), 
                textColor: Colors.black,
                onPressed: () {
                // navigation
              },),
              SizedBox(height: 8,),
              CustomButton(
                icon: FontAwesomeIcons.apple, 
                text: 'Continue with Apple', 
                backgroundColor: Color(0xffD9D9D9), 
                textColor: Colors.black,
                onPressed: () {
                // navigation
              },),
              SizedBox(height: 8,),
              CustomButton(
                icon: FontAwesomeIcons.facebook, 
                text: 'Continue with Facebook', 
                backgroundColor: Color(0xffD9D9D9), 
                textColor: Colors.black,
                onPressed: () {
                // navigation
              },),

          ],
        ),
      ),
    );
  }
}