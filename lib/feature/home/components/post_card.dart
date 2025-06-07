import 'package:flutter/material.dart';
import 'package:flutter_app/feature/home/post_model.dart';
import 'package:flutter_app/feature/home/posts_controller.dart';
import 'package:flutter_app/feature/profile/user_model.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final UserModel user;
  final bool isEditable;
  final TextEditingController? editController;

  const PostCard({
    super.key,
    required this.post,
    required this.user,
    this.isEditable = false,
    this.editController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.grey.withAlpha(50),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePictureUrl),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.name,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (isEditable) ...[
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              if (editController != null) {
                                editController!.text = post.content;
                              }
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Edit Post'),
                                  content: TextFormField(
                                    controller: editController,
                                    maxLines: 3,
                                    decoration: const InputDecoration(
                                      labelText: 'Post Content',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await PostsController()
                                            .updatePostContent(
                                              post.id,
                                              editController!.text,
                                            );

                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Delete Post'),
                                  content: const Text(
                                    'Are you sure you want to delete this post?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await PostsController().deletePost(
                                          post.id,
                                        );
                                        if (context.mounted) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                    if (post.createdAt.toIso8601String().substring(0, 19) !=
                        post.updatedAt.toIso8601String().substring(0, 19))
                      Text(
                        'Edited',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    Text(
                      DateFormat('yMMMMd – h:mm a').format(post.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
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
  }
}
