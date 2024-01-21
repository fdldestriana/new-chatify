import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/data/model/user_app.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<List<UserApp>> getUsers() async {
    List<UserApp> userList = [];
    await users.get().then(
      (value) {
        final data = value.docs;
        userList = data
            .where((element) => element.id != firebaseAuth.currentUser!.uid)
            .map((e) {
          Map<String, dynamic> newData = e.data() as Map<String, dynamic>;
          return UserApp.fromJson(newData);
        }).toList();
      },
      onError: (error) {
        throw Exception(error.toString());
      },
    );
    return userList;
  }
}
