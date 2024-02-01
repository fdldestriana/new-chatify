import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain/userlist/entities/userlist_item_entity.dart';

abstract class UserListRepository {
  Future<Either<Failure, UserListItemEntity>> getUserListItems();
}
