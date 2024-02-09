import 'package:new_chatify/domain/shared/entities/message_entity.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';

class ChatRoomsListEntity {
  final UserAppEntity userApp;
  final MessageEntity latestMessage;

  ChatRoomsListEntity({required this.userApp, required this.latestMessage});
}
