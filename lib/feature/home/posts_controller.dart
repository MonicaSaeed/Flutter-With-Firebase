import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/feature/home/post_model.dart';

import '../../core/services/toast_helper.dart';

class PostsController {
  static final PostsController _instance = PostsController._internal();
  factory PostsController() {
    return _instance;
  }
  PostsController._internal();

  Future<void> createPost(PostModel post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').add(post.toMap());
      ToastHelper.showSuccess("Post added successfully");
    } catch (e) {
      ToastHelper.showError("Failed to add post: ${e.toString()}");
    }
  }

  Stream<List<PostModel>> getPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PostModel.fromMap(doc.data())..id = doc.id;
          }).toList();
        });
  }

  Stream<List<PostModel>> getPostsByUser(String userId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('authorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PostModel.fromMap(doc.data())..id = doc.id;
          }).toList();
        });
  }

  Stream<List<PostModel>> getPostsExcludingCurrentUser(String currentUserId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('authorId', isNotEqualTo: currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PostModel.fromMap(doc.data())..id = doc.id;
          }).toList();
        });
  }
}
