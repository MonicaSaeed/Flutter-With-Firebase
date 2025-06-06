import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feature/home/post_model.dart';
import 'package:flutter_app/feature/home/posts_controller.dart';
import 'package:flutter_app/feature/profile/profile_screen.dart';
import 'package:flutter_app/feature/profile/user_controller.dart';
import 'package:intl/intl.dart';

import '../profile/user_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final postContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome to posts app'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<PostModel>>(
        stream: PostsController().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/empty.png'),
                  Text(
                    "No posts available.",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Be the first to create a post!",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          final posts = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: posts.length,
              physics: BouncingScrollPhysics(),

              itemBuilder: (context, index) {
                final post = posts[index];
                return FutureBuilder<UserModel>(
                  future: UserController().getUserById(post.authorId),
                  // stream:
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return ListTile(title: Text("Loading user..."));
                    }

                    if (userSnapshot.hasError) {
                      return ListTile(
                        title: Text("Error: ${userSnapshot.error}"),
                      );
                    }
                    final userData = userSnapshot.data!.toMap();
                    final authorName = userData['name'] ?? 'Unknown';
                    final profileImageUrl = userData['profilePictureUrl'];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.grey.withValues(alpha: 50),

                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(profileImageUrl),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authorName,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    DateFormat(
                                      'yMMMMd – h:mm a',
                                    ).format(post.createdAt),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              Spacer(),
                              if (post.createdAt != post.updatedAt)
                                Text(
                                  'Edited',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            post.content,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Post Content',
                          border: OutlineInputBorder(),
                        ),
                        controller: postContentController,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter post content';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            if (currentUser == null) return;

                            // Fetch user data using UID
                            final userDoc = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(currentUser.uid)
                                .get();

                            String authorName = 'Unknown';
                            if (userDoc.exists && userDoc.data() != null) {
                              final data = userDoc.data()!;
                              authorName = data['name'] ?? 'Unknown';
                            }

                            final post = PostModel(
                              content: postContentController.text,
                              createdAt: DateTime.now(),
                              author: authorName,
                              authorId: currentUser.uid,
                            );

                            await PostsController().createPost(post);
                            postContentController.clear();

                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },

                        child: Text('Create'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
