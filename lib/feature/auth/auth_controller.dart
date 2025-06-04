import 'package:firebase_auth/firebase_auth.dart';

import '../../core/services/toast_helper.dart';

class AuthController {
  Future<void> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      ToastHelper.showSuccess("Sign Up Successful");
    } catch (e) {
      ToastHelper.showError("Sign Up Failed: ${e.toString()}");
    }
  }
}
