import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/data/shared/models/message_model.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';

abstract class ChatRoomsListDataSource {
  Future<List<UserAppModel>> getUserList();
}

class ChatRoomsListDataSourceImpl implements ChatRoomsListDataSource {
  User? currentUser = FirebaseAuth.instance.currentUser;
  List<UserAppModel> _userList = [];
  @override
  Future<List<UserAppModel>> getUserList() async {
    var data = await getUserIdsFromChatRooms();
    var userModels = await getUserModel(data);
    var messageModels = await getLatestMessages(data);
    List<Map<String, dynamic>> map = [];
    for (int index = 0; index < userModels.length; index++) {
      map.add(
        {
          "user": userModels[index],
          "latestMessage": messageModels[index],
        },
      );
    }
    map.forEach((element) {
      print("USER LATEST MESSAGE FROM UP ${element.keys}");
      print("USER LATEST MESSAGE FROM UP ${element.values}");
    });

    await FirebaseFirestore.instance
        .collection("users")
        .where("latestMessage.receiverId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (value) {
        final docs = value.docs;
        _userList = docs
            .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
            .map(
          (doc) {
            Map<String, dynamic> data = doc.data();
            return UserAppModel.fromMap(data);
          },
        ).toList();
      },
      onError: (e) {
        throw Exception(e.toString());
      },
    );
    await FirebaseFirestore.instance
        .collection("users")
        .where("latestMessage.senderId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        // .orderBy("latestMessage.timestamp", descending: true)
        .get()
        .then(
      (value) {
        final docs = value.docs;
        var newUserList = docs
            .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
            .map(
          (doc) {
            Map<String, dynamic> data = doc.data();
            return UserAppModel.fromMap(data);
          },
        ).toList();
        _userList.addAll(newUserList);
      },
      onError: (e) {
        throw Exception(e.toString());
      },
    );
    return _userList;
  }

  Future<List<String>> getUserIdsFromChatRooms() async {
    List<String> chatRooms = [];
    await FirebaseFirestore.instance.collection("chats").get().then(
      (value) {
        final docs = value.docs;
        docs
            .map((doc) => doc.data()["docId"].toString())
            .toList()
            .forEach((element) {
          chatRooms.add(element);
        });
      },
      onError: (e) {
        throw Exception(e.toString());
      },
    );
    print("USER IDS $chatRooms");
    return chatRooms;
  }

  Future<List<UserAppModel>> getUserModel(List<String> ids) async {
    List<UserAppModel> userList = [];
    var newList = [];
    for (var element in ids) {
      newList.addAll(element.split("_"));
    }
    newList.removeWhere(
        (element) => element == FirebaseAuth.instance.currentUser!.uid);
    for (var id in newList) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .get()
          .then((value) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        userList.add(UserAppModel.fromMap(data));
      }).onError((e, _) => throw Exception(e.toString()));
    }

    userList.forEach((element) {
      print("USER EMAIL ${element.email}");
    });
    return userList;
  }

  Future<List<MessageModel>> getLatestMessages(List<String> ids) async {
    List<MessageModel> messages = [];
    for (String id in ids) {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(id)
          .collection("messages")
          .orderBy("timestamp")
          .get()
          .then((value) {
        var data = value.docs.last;
        messages.add(MessageModel.fromMap(data.data()));
      }).onError((e, _) => throw Exception(e.toString()));
    }
    messages.forEach((element) {
      print("USER MESSAGE ${element.message}");
    });
    return messages;
  }
}
