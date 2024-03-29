import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chatify/domain/shared/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.message,
    required super.receiverId,
    required super.senderId,
    required super.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic>? map) {
    MessageModel messageModel = (map != null)
        ? MessageModel(
            message: map["message"],
            receiverId: map["receiverId"],
            senderId: map["senderId"],
            timestamp: map["timestamp"],
          )
        : MessageModel.empty();
    return messageModel;
  }

  factory MessageModel.empty() {
    return MessageModel(
      message: "",
      receiverId: "",
      senderId: "",
      timestamp: Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "receiverId": receiverId,
      "senderId": senderId,
      "timestamp": timestamp
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      message: message,
      receiverId: receiverId,
      senderId: senderId,
      timestamp: timestamp,
    );
  }
}
