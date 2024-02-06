import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';
import 'package:new_chatify/data/chatroomslist/datasources/userlist_datasource.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/userlist_repository.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListDataSource userListDataSource;
  UserListRepositoryImpl({required this.userListDataSource});

  @override
  Future<Either<Failure, List<UserAppEntity>>> getUserList() async {
    @override
    List<UserAppEntity> users = [];
    try {
      List<UserAppModel> data = await userListDataSource.getUserList();
      for (UserAppModel user in data) {
        users.add(user.toEntity());
      }
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
    return Right(users);
  }
}
