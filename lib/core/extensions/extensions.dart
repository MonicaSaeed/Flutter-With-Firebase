extension StringExtensions on String {
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Password validation containing at least 8 characters, one uppercase letter, one lowercase letter, one number, and one special character
  bool get isValidPassword {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }

  /// User name validation containing only alphanumeric characters and underscores, with a length between 3 and 20 characters
  bool get isValidUsername {
    final usernameRegex = RegExp(r'^[a-zA-Z_]{3,20}$');
    return usernameRegex.hasMatch(this);
  }
}
