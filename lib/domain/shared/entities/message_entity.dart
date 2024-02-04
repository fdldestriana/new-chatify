import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  final String message;
  final String receiverId;
  final String senderId;
  final Timestamp timestamp;

  MessageEntity({
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.timestamp,
  });
}
