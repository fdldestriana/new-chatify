import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chatify/data/shared/models/message_model.dart';

abstract class ChatDataSource {
  Future<void> sendMessage(String docId, Map<String, dynamic> message);
  Stream<List<MessageModel>> getMessages(String docId);
}

class ChatDataSourceImpl extends ChatDataSource {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<MessageModel>> getMessages(String docId) async* {
    try {
      yield* firebaseFirestore
          .collection("chats")
          .doc(docId)
          .collection("messages")
          .orderBy("timestamp", descending: false)
          .snapshots()
          .map(
            (event) => event.docs.map((doc) {
              return MessageModel.fromMap(doc.data());
            }).toList(),
          );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> sendMessage(String docId, Map<String, dynamic> message) async {
    try {
      // firebaseFirestore
      //     .collection("chats")
      //     .doc(docId)
      //     .collection("messages")
      //     .add(message);
      firebaseFirestore
          .collection("chats")
          .doc(docId)
          .set({"docId": docId}).then((value) {
        firebaseFirestore
            .collection("chats")
            .doc(docId)
            .collection("messages")
            .add(message);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
