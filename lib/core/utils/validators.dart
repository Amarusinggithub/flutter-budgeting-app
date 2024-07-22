class Validators {
  static String? validateEmail(String? email) {
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else if (regex.hasMatch(email)) {
      return email;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    // Add more password validation logic here
    return null;
  }
}
