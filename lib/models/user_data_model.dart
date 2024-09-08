class UserDataModel {
  String username;
  String email;

  UserDataModel({required this.username, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> map) {
    return UserDataModel(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
    );
  }
}
