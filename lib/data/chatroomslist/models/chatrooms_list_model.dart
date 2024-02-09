import 'package:new_chatify/domain/chatroomslist/entities/chatrooms_list_entity.dart';

class ChatRoomsListModel extends ChatRoomsListEntity {
  ChatRoomsListModel({required super.userApp, required super.latestMessage});

  factory ChatRoomsListModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomsListModel(
      userApp: map["userApp"],
      latestMessage: map["latestMessage"],
    );
  }

  ChatRoomsListModel toEntity() {
    return ChatRoomsListModel(
      userApp: userApp,
      latestMessage: latestMessage,
    );
  }
}
