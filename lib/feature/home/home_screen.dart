import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feature/home/post_model.dart';
import 'package:flutter_app/feature/home/posts_controller.dart';
import 'package:flutter_app/feature/profile/components/create_post.dart';
import 'package:flutter_app/feature/profile/profile_screen.dart';
import 'package:flutter_app/feature/profile/user_controller.dart';

import '../profile/user_model.dart';
import 'components/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        stream: PostsController().getPostsExcludingCurrentUser(
          FirebaseAuth.instance.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final post = posts[index];
                return FutureBuilder<UserModel>(
                  future: UserController().getUserById(post.authorId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const ListTile(title: Text("Loading user..."));
                    }

                    if (userSnapshot.hasError) {
                      return ListTile(
                        title: Text("Error: ${userSnapshot.error}"),
                      );
                    }

                    final userData = userSnapshot.data!;
                    return PostCard(post: post, user: userData);
                  },
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: CreatePost(),
    );
  }
}
