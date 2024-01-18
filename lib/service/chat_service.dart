import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chatify/data/model/user.dart';

class ChatService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  Future<List<User>> getUser() async {
    List<User> userList = [];
    users.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        userList.add(User(id: doc.id, email: data["email"]));
      });
    });
    return userList;
  }
}
