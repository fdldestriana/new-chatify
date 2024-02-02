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
    List<MessageModel> latestMessages = [];
    List<Map<String, dynamic>> userListItem = [];

    // await FirebaseFirestore.instance.collection("users").get().then(
    //   (value) {
    //     final docs = value.docs;
    //     userList = docs
    //         .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
    //         .map(
    //       (doc) {
    //         Map<String, dynamic> data = doc.data();
    //         return UserAppModel.fromMap(data);
    //       },
    //     ).toList();
    //   },
    //   onError: (e) {
    //     throw Exception(e.toString());
    //   },
    // );
    // await FirebaseFirestore.instance.collection("chats").get().then(
    //   (value) {
    //     print("VALUE ${value.docs.length}");
    //     var docs = value.docs;
    //     for (var doc in docs) {
    //       if (doc.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
    //         FirebaseFirestore.instance
    //             .collection("chats")
    //             .doc(doc.id)
    //             .collection("messages")
    //             .get()
    //             .then(
    //           (value) {
    //             var docs = value.docs;
    //             docs.map(
    //               (e) {
    //                 Map<String, dynamic> data = e.data();
    //                 latestMessages.add(
    //                   MessageModel.fromMap(data),
    //                 );
    //               },
    //             ).toList();
    //           },
    //         );
    //       }
    //     }
    //   },
    // );
    if (FirebaseAuth.instance.currentUser != null) {
      // var userQuery =
      //     await FirebaseFirestore.instance.collection("users").get();
      // var userDocs = userQuery.docs;
      // print("VALUE user ${userDocs.length}");

      // userList = userDocs
      //     .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
      //     .map((doc) => UserAppModel.fromMap(doc.data()))
      //     .toList();

      var chatQuery =
          await FirebaseFirestore.instance.collection("chats").get();
      var chatDocs = chatQuery.docs;
      print("VALUE chat ${chatDocs.length}");

      // for (var chatDoc in chatDocs) {
      //   if (chatDoc.id.contains(FirebaseAuth.instance.currentUser!.uid)) {
      //     var messagesQuery = await FirebaseFirestore.instance
      //         .collection("chats")
      //         .doc(chatDoc.id)
      //         .collection("messages")
      //         .get();

      //     var messageDocs = messagesQuery.docs;

      //     latestMessages.addAll(messageDocs
      //         .map((messageDoc) => MessageModel.fromMap(messageDoc.data())));
      //   }
      // }

      for (var user in userList) {
        var userIds = [user.uid, FirebaseAuth.instance.currentUser!.uid];
        userIds.sort();
        var userDocId = userIds.join("_");
        for (var message in latestMessages) {
          var userIds = [message.senderId, message.receiverId];
          userIds.sort();
          var messageDocId = userIds.join("_");
          if (userDocId == messageDocId) {
            userListItem.add({"user": user, "latestMessage": message});
          } else {
            userListItem.add({"user": user, "latestMessage": ""});
          }
        }
      }
    }

    return UserListItemModel(userListItem: userListItem);
  }
}
