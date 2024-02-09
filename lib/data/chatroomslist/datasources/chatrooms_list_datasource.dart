import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/data/chatroomslist/models/chatrooms_list_model.dart';
import 'package:new_chatify/data/shared/models/message_model.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';

abstract class ChatRoomsListDataSource {
  Future<List<ChatRoomsListModel>> getChatRoomsList();
}

class ChatRoomsListDataSourceImpl implements ChatRoomsListDataSource {
  final List<ChatRoomsListModel> _chatRoomsList = [];

  @override
  Future<List<ChatRoomsListModel>> getChatRoomsList() async {
    _chatRoomsList.clear();
    var data = await getUserIdsFromChatRooms();
    var userModels = await getUserModel(data);
    var messageModels = await getLatestMessages(data);

    try {
      for (int index = 0; index < userModels.length; index++) {
        _chatRoomsList.add(
          ChatRoomsListModel.fromMap(
            {
              "userApp": userModels[index],
              "latestMessage": messageModels[index]
            },
          ),
        );
      }

      return _chatRoomsList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<String>> getUserIdsFromChatRooms() async {
    List<String> chatRooms = [];
    chatRooms.clear();
    await FirebaseFirestore.instance.collection("chats").get().then(
      (value) {
        final docs = value.docs;
        chatRooms = docs.map((doc) => doc.data()["docId"].toString()).toList();
        chatRooms.removeWhere((element) =>
            !element.contains(FirebaseAuth.instance.currentUser!.uid));
      },
      onError: (e) {
        throw Exception(e.toString());
      },
    );
    return chatRooms;
  }

  Future<List<UserAppModel>> getUserModel(List<String> ids) async {
    List<UserAppModel> userList = [];
    userList.clear();
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
    return userList;
  }

  Future<List<MessageModel>> getLatestMessages(List<String> ids) async {
    List<MessageModel> messages = [];
    messages.clear();
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
    return messages;
  }
}
