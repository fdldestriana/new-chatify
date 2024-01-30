// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:new_chatify/data/model/message.dart';

// class ChatService {
//   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   Future<void> sendMessages(
//       {required String docId, required Message message}) async {
//     try {
//       firebaseFirestore
//           .collection("chats")
//           .doc(docId)
//           .collection("messages")
//           .add(message.toJson());
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Stream<List<Message>> getMessages({required String docId}) async* {
//     try {
//       yield* firebaseFirestore
//           .collection("chats")
//           .doc(docId)
//           .collection("messages")
//           .orderBy("timestamp", descending: false)
//           .snapshots()
//           .map(
//             (event) => event.docs.map((doc) {
//               return Message.fromJson(doc.data());
//             }).toList(),
//           );
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
// }
