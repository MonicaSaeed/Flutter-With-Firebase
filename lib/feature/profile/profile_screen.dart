import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feature/home/posts_controller.dart';
import 'package:flutter_app/feature/profile/components/alert_dialog_change_user_data.dart';
import 'package:flutter_app/feature/profile/components/create_post.dart';
import 'package:flutter_app/feature/profile/user_controller.dart';
import 'package:flutter_app/feature/profile/user_model.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import '../auth/login_screen.dart';
import '../home/post_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  get postContentController => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthController().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<UserModel?>(
        stream: UserController().getCurrentUserStream(
          FirebaseAuth.instance.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("User not found."));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.profilePictureUrl),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogChangeUserData(user: user);
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Posts',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  // Makes the post list scrollable
                  child: StreamBuilder<List<PostModel>>(
                    stream: PostsController().getPostsByUser(user.uid),
                    builder: (context, postSnapshot) {
                      if (postSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (postSnapshot.hasError) {
                        return Center(
                          child: Text("Error: ${postSnapshot.error}"),
                        );
                      } else if (!postSnapshot.hasData ||
                          postSnapshot.data!.isEmpty) {
                        return const Center(child: Text("No posts available."));
                      }

                      final posts = postSnapshot.data!;
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat(
                                      'yMMMMd – h:mm a',
                                    ).format(post.createdAt),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    post.content,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: CreatePost(),
    );
  }
}
