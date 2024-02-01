import 'package:new_chatify/domain/userlist/entities/userlist_item_entity.dart';

class UserListItemModel extends UserListItemEntity {
  UserListItemModel({required super.userList, required super.lastMessages});

  UserListItemEntity toEntity() {
    return UserListItemEntity(userList: userList, lastMessages: lastMessages);
  }
}
