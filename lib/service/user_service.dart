import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/data/model/user_app.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<List<UserApp>> getUsers() async {
    List<UserApp> userList = [];
    await users.get().then(
      (value) {
        final data = value.docs;
        userList =
            data.where((element) => element.id != currentUser!.uid).map((e) {
          Map<String, dynamic> newData = e.data() as Map<String, dynamic>;
          return UserApp(id: newData["uid"], email: newData["email"]);
        }).toList();
      },
      onError: (error) {
        throw Exception(error.toString());
      },
    );
    return userList;
  }
}
