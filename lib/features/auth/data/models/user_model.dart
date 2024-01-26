class UserModel {
  final String uid;
  final String email;
  final String password;

  UserModel({required this.uid, required this.email, required this.password});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      password: map["password"],
    );
  }
}
