import 'package:new_chatify/domain/shared/entities/message_entity.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';

class UserListItemEntity {
  final List<UserAppEntity> userList;
  final List<MessageEntity> lastMessages;

  UserListItemEntity({required this.userList, required this.lastMessages});
}
