import 'package:firebase_auth/firebase_auth.dart';

import '../../core/services/toast_helper.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() {
    return _instance;
  }
  AuthController._internal();

  bool isLoggedIn = false;

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        ToastHelper.showSuccess("Verification email sent. Please verify.");
      }
      return user;
    } catch (e) {
      ToastHelper.showError("Sign Up Failed: ${e.toString()}");
      return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn = true;
      ToastHelper.showSuccess("Login Successful");
    } catch (e) {
      ToastHelper.showError("Login Failed: ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      ToastHelper.showSuccess("Logout Successful");
    } catch (e) {
      ToastHelper.showError("Logout Failed: ${e.toString()}");
    }
  }

  Future<void> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        ToastHelper.showSuccess("Verification Email Sent");
      } catch (e) {
        ToastHelper.showError(
          "Failed to send verification email: ${e.toString()}",
        );
      }
    } else {
      ToastHelper.showError(
        "No user is currently signed in or email is already verified.",
      );
    }
  }
}
