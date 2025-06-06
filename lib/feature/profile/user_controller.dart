import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/feature/profile/user_model.dart';

import '../../core/services/toast_helper.dart';

class UserController {
  static final UserController _instance = UserController._internal();
  factory UserController() {
    return _instance;
  }
  UserController._internal();

  Future<void> createUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
      ToastHelper.showSuccess("User created successfully");
    } catch (e) {
      ToastHelper.showError("Failed to add user: ${e.toString()}");
    }
  }

  Stream<UserModel?> getCurrentUserStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
          if (doc.exists && doc.data() != null) {
            return UserModel.fromMap(doc.data() as Map<String, dynamic>);
          } else {
            ToastHelper.showError("User not found");
            return null;
          }
        });
  }
}
