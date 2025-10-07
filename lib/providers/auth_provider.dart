import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    // Automatically listen for user changes
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  // ------------------ Email Login ------------------
  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithEmail(email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  // ------------------ Email Signup ------------------
  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.signUpWithEmail(email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  // ------------------ Google Login ------------------
  Future<void> loginWithGoogle() async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithGoogle();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  // ------------------ Facebook Login ------------------
  Future<void> loginWithFacebook() async {
    _setLoading(true);
    try {
      _user = await _authService.signInWithFacebook();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _setLoading(false);
  }

  // ------------------ Logout ------------------
  Future<void> logout() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // ------------------ Helpers ------------------
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
