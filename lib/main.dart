import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:redora/ViewModel/view_model.dart';
import 'package:redora/view/homecreen.dart';
import 'package:redora/view/login_screen.dart';
import 'firebase_options.dart';
import 'view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Redora - Book Reader',
      theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Poppins'),
      home: const SplashScreen(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        if (authViewModel.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xff0F1030),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xff1255F1)),
            ),
          );
        }
        if (authViewModel.isAuthenticated) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
