import 'package:flutter/material.dart';
import 'package:flutter_app/core/extensions/extensions.dart';

import '../user_controller.dart';
import '../user_model.dart';

class AlertDialogChangeUserData extends StatelessWidget {
  AlertDialogChangeUserData({super.key, required this.user});

  final _formKey = GlobalKey<FormState>();
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: const Text('Edit Profile'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: user.name,
                onChanged: (value) {
                  user.name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  if (!value.isValidUsername) {
                    return 'Username must be at least 3 characters long and can only contain letters, and underscores';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: user.profilePictureUrl,
                decoration: const InputDecoration(
                  labelText: 'Profile Picture URL',
                ),
                onChanged: (value) {
                  user.profilePictureUrl = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid URL';
                  }
                  if (!Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await UserController().updateUserProfile(
                  uid: user.uid,
                  name: user.name,
                  profilePictureUrl: user.profilePictureUrl,
                );
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
