import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _isGoogleInitialized = false;
  GoogleSignInAccount? _currentGoogleUser;

  AuthService() {
    _initializeGoogle();
  }

  // ---------------------- GOOGLE INITIALIZATION ----------------------
  Future<void> _initializeGoogle() async {
    try {
      await _googleSignIn.initialize();
      _isGoogleInitialized = true;
    } catch (e) {
      throw Exception('Google Sign-In initialization failed: $e');
    }
  }

  Future<void> _ensureGoogleInitialized() async {
    if (!_isGoogleInitialized) {
      await _initializeGoogle();
    }
  }

  // ---------------------- EMAIL SIGNUP ----------------------
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Signup failed');
    }
  }

  // ---------------------- EMAIL LOGIN ----------------------
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Login failed');
    }
  }

  // ---------------------- GOOGLE SIGN-IN ----------------------
  Future<User?> signInWithGoogle() async {
    await _ensureGoogleInitialized();

    try {
      final googleUser = await _googleSignIn.authenticate(scopeHint: ['email']);
      _currentGoogleUser = googleUser;

      final googleAuth = googleUser.authentication; // now synchronous
      final authorization = await _googleSignIn.authorizationClient
          .authorizationForScopes(['email']);

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: authorization?.accessToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on GoogleSignInException catch (e) {
      _currentGoogleUser = null;
      throw Exception(
        'Google Sign-In failed: ${e.code.name} - ${e.description}',
      );
    } on FirebaseAuthException catch (e) {
      _currentGoogleUser = null;
      throw Exception('Firebase Auth failed: ${e.message}');
    } catch (e) {
      _currentGoogleUser = null;
      throw Exception('Google Sign-In failed: $e');
    }
  }

  // ---------------------- FACEBOOK SIGN-IN ----------------------
  Future<User?> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success && result.accessToken != null) {
        final credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );
        final userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      } else if (result.status == LoginStatus.cancelled) {
        return null; // user cancelled login
      } else {
        throw Exception(result.message ?? 'Facebook sign-in failed');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception('Facebook Auth failed: ${e.message}');
    } catch (e) {
      throw Exception('Facebook sign-in failed: $e');
    }
  }

  // ---------------------- SIGN OUT ----------------------
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
        FacebookAuth.instance.logOut(),
      ]);
      _currentGoogleUser = null;
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // ---------------------- GETTERS ----------------------
  User? get currentUser => _auth.currentUser;
  GoogleSignInAccount? get currentGoogleUser => _currentGoogleUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Stream<User?> get userChanges => _auth.userChanges();
}
