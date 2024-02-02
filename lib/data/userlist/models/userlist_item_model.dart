import 'package:new_chatify/domain/userlist/entities/userlist_item_entity.dart';

class UserListItemModel extends UserListItemEntity {
  UserListItemModel({required super.userListItem});

  UserListItemEntity toEntity() {
    return UserListItemEntity(userListItem: super.userListItem);
  }
}
