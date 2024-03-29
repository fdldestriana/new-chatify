import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';

abstract class UserListRepository {
  Future<Either<Failure, List<UserAppEntity>>> getUserList();
}
