import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isGoogleSignInInitialized = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthViewModel() {
    _initializeGoogleSignIn();
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize Google Sign-In: $e');
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      _errorMessage = null;
      _setLoading(false);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.code == "user-not-found"
          ? "No user found for that email."
          : e.message ?? "Login failed";
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      _errorMessage = null;
      _setLoading(false);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "Signup failed";
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    try {
      await _ensureGoogleSignInInitialized();

      // Check if authenticate is supported on this platform
      if (!_googleSignIn.supportsAuthenticate()) {
        _errorMessage = "Google Sign-In not supported on this platform";
        _setLoading(false);
        notifyListeners();
        return false;
      }

      // Authenticate with Google (v7.x method)
      final googleUser = await _googleSignIn.authenticate(scopeHint: ['email']);

      // Get authentication tokens (synchronous in v7.x)
      final googleAuth = googleUser.authentication;

      // Get access token using authorization client
      final authClient = _googleSignIn.authorizationClient;
      final authorization = await authClient.authorizationForScopes(['email']);

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: authorization?.accessToken,
      );

      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      _errorMessage = null;
      _setLoading(false);
      notifyListeners();
      return true;
    } on GoogleSignInException catch (e) {
      _errorMessage = _getGoogleSignInErrorMessage(e);
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  String _getGoogleSignInErrorMessage(GoogleSignInException e) {
    switch (e.code.name) {
      case 'canceled':
        return 'Sign-in was cancelled';
      case 'interrupted':
        return 'Sign-in was interrupted. Please try again';
      case 'clientConfigurationError':
        return 'Configuration issue with Google Sign-In';
      case 'providerConfigurationError':
        return 'Google Sign-In is currently unavailable';
      case 'uiUnavailable':
        return 'Google Sign-In UI is currently unavailable';
      case 'userMismatch':
        return 'Account mismatch. Please sign out and try again';
      default:
        return 'An unexpected error occurred during Google Sign-In';
    }
  }

  Future<bool> loginWithFacebook() async {
    _setLoading(true);
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success && result.accessToken != null) {
        final credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );
        final userCredential = await _auth.signInWithCredential(credential);
        _user = userCredential.user;
        _errorMessage = null;
        _setLoading(false);
        notifyListeners();
        return true;
      } else {
        _errorMessage = result.message ?? "Facebook login failed";
        _user = null;
        _setLoading(false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.disconnect();
    await FacebookAuth.instance.logOut();
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
