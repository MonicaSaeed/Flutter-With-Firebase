class UserModel {
  String uid;
  String name;
  String email;
  String profilePictureUrl =
      'https://cdn.vectorstock.com/i/1000v/66/13/default-avatar-profile-icon-social-media-user-vector-49816613.jpg';
  List<String> postsIds = [];

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePictureUrl =
        'https://cdn.vectorstock.com/i/1000v/66/13/default-avatar-profile-icon-social-media-user-vector-49816613.jpg',
    this.postsIds = const [],
  });

  UserModel.fromMap(Map<String, dynamic> json)
    : uid = json['uid'] ?? '',
      name = json['name'] ?? '',
      email = json['email'] ?? '',
      profilePictureUrl =
          json['profilePictureUrl'] ??
          'https://cdn.vectorstock.com/i/1000v/66/13/default-avatar-profile-icon-social-media-user-vector-49816613.jpg',
      postsIds = List<String>.from(json['postsIds'] ?? []);

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'postsIds': postsIds,
    };
  }

  factory UserModel.copyWith({
    required UserModel user,
    String? uid,
    String? name,
    String? email,
    String? profilePictureUrl,
    List<String>? postsIds,
  }) {
    return UserModel(
      uid: uid ?? user.uid,
      name: name ?? user.name,
      email: email ?? user.email,
      profilePictureUrl: profilePictureUrl ?? user.profilePictureUrl,
      postsIds: postsIds ?? user.postsIds,
    );
  }
  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, profilePictureUrl: $profilePictureUrl, postsIds: $postsIds)';
  }
}
