import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chatify/data/model/user.dart';

class ChatService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future<List<User>> getUser() async {
    List<User> userList = [];
    await users.get().then(
      (value) {
        final data = value.docs;
        userList = data.map(
          (e) {
            var newData = e.data() as Map<String, dynamic>;
            return User(id: newData["uid"], email: newData["email"]);
          },
        ).toList();
      },
      onError: (error) {
        throw Exception(error.toString());
      },
    );
    return userList;
  }
}
