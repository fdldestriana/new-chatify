import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String receiverId;
  final String senderId;
  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.receiverId,
      required this.senderId,
      required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json["message"],
        receiverId: json["receiverId"],
        senderId: json["senderId"],
        timestamp: json["timestamp"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "receiverId": receiverId,
      "senderId": senderId,
      "timestamp": timestamp
    };
  }
}
