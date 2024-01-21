import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chatify/data/model/message.dart';

class ChatService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createChatRoom(
      {required String docId, required Message message}) async {
    try {
      firebaseFirestore
          .collection("chats")
          .doc(docId)
          .set(message.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
