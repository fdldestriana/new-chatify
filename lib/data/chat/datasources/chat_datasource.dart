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
    var ids = docId.split("_");
    try {
      firebaseFirestore
          .collection("chats")
          .doc(docId)
          .collection("messages")
          .add(message);

      for (var id in ids) {
        firebaseFirestore
            .collection("users")
            .doc(id)
            .update({"latestMessage": message});
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
