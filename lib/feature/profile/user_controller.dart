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

  Future<void> updateUserProfile({
    required String uid,
    String? profilePictureUrl,
    String? name,
  }) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
      final updates = <String, dynamic>{};
      if (profilePictureUrl != null) {
        updates['profilePictureUrl'] = profilePictureUrl;
      }
      if (name != null) {
        updates['name'] = name;
      }
      await userDoc.update(updates);
      ToastHelper.showSuccess("User profile updated successfully");
    } catch (e) {
      ToastHelper.showError("Failed to update user profile: ${e.toString()}");
    }
  }
}
