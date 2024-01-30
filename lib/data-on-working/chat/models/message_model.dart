import 'package:new_chatify/domain-on-working/chat/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.message,
    required super.receiverId,
    required super.senderId,
    required super.timestamp,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map["message"],
      receiverId: map["receiverId"],
      senderId: map["senderId"],
      timestamp: map["timestamp"],
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
