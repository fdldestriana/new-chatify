import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/data/shared/models/message_model.dart';
import 'package:new_chatify/data/shared/models/user_model.dart';
import 'package:new_chatify/data/userlist/models/userlist_item_model.dart';

abstract class UserListDataSource {
  // Future<List<UserAppModel>> getUsers();
  Future<UserListItemModel> getUserListItems();
}

class UserListDataSourceImpl implements UserListDataSource {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference _chats =
      FirebaseFirestore.instance.collection("chats");

  // @override
  // Future<List<UserAppModel>> getUsers() async {
  //   List<UserAppModel> userList = [];
  //   await _users.get().then(
  //     (value) {
  //       final docs = value.docs;
  //       userList = docs
  //           .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
  //           .map(
  //         (doc) {
  //           Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //           return UserAppModel.fromMap(data);
  //         },
  //       ).toList();
  //     },
  //     onError: (e) {
  //       throw Exception(e.toString());
  //     },
  //   );
  //   return userList;
  // }

  @override
  Future<UserListItemModel> getUserListItems() async {
    List<UserAppModel> userList = [];
    List<MessageModel> lastMessages = [];
    await _users.get().then(
      (value) {
        final docs = value.docs;
        userList = docs
            .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
            .map(
          (doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return UserAppModel.fromMap(data);
          },
        ).toList();
      },
      onError: (e) {
        throw Exception(e.toString());
      },
    );
    await _chats.get().then(
      (value) async {
        for (QueryDocumentSnapshot doc in value.docs) {
          if (doc.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
            var data = await FirebaseFirestore.instance
                .doc(doc.id)
                .collection("messages")
                .get();
            final docs = data.docs;
            lastMessages = docs.map(
              (e) {
                Map<String, dynamic> data = e.data();
                return MessageModel.fromMap(data);
              },
            ).toList();
            //   .then(
            // (value) async {
            //   final docs = value.docs;
            //   lastMessages = docs.map(
            //     (e) {
            //       Map<String, dynamic> data = e.data();
            //       return MessageModel.fromMap(data);
            //     },
            //   ).toList();
            // },
            // onError: (e) {
            //   throw Exception(e.toString());
            // },
          }
        }
      },
    );
    return UserListItemModel(userList: userList, lastMessages: lastMessages);
  }
}
