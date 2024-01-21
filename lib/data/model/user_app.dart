class UserApp {
  final String uid;
  final String email;

  UserApp({required this.uid, required this.email});

  factory UserApp.fromJson(Map<String, dynamic> json) {
    return UserApp(uid: json["uid"], email: json["email"]);
  }
}
