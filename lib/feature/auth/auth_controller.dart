import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/feature/profile/user_model.dart';

import '../../core/services/toast_helper.dart';
import '../profile/user_controller.dart';

class AuthController {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() {
    return _instance;
  }
  AuthController._internal();

  Future<User?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        UserModel newUser = UserModel(uid: user.uid, email: email, name: name);
        await UserController().createUser(newUser);
        await sendEmailVerification(user);
        ToastHelper.showSuccess("Verification email sent. Please verify.");
      }
      return user;
    } catch (e) {
      ToastHelper.showError("Sign Up Failed: ${e.toString()}");
      return null;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      if (user != null && user.emailVerified) {
        ToastHelper.showSuccess("Login Successful");
        return true;
      } else {
        ToastHelper.showError("Please verify your email before logging in.");
        return false;
      }
    } catch (e) {
      ToastHelper.showError("Login Failed: ${e.toString()}");
    }
    return false;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      ToastHelper.showSuccess("Logout Successful");
    } catch (e) {
      ToastHelper.showError("Logout Failed: ${e.toString()}");
    }
  }

  Future<void> sendEmailVerification(User user) async {
    if (!user.emailVerified) {
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

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ToastHelper.showSuccess("Password reset email sent.");
    } catch (e) {
      ToastHelper.showError(
        "Failed to send password reset email: ${e.toString()}",
      );
    }
  }
}
