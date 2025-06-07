import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/post_model.dart';
import '../../home/posts_controller.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final postContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
                          final post = PostModel(
                            content: postContentController.text,
                            createdAt: DateTime.now(),
                            authorId: FirebaseAuth.instance.currentUser!.uid,
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
    );
  }
}
