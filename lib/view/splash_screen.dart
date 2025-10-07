import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redora/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _displayedText = "";
  final String _fullText = "Redora";

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      _showLettersOneByOne();
    });
  }

  void _showLettersOneByOne() {
    int index = 0;
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (index < _fullText.length) {
        setState(() {
          _displayedText += _fullText[index];
        });
        index++;
      } else {
        timer.cancel();
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const AuthWrapper()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F192D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Text(
              _displayedText,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
