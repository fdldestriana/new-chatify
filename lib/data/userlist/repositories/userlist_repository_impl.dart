import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/userlist/datasources/userlist_datasource.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/userlist/repositories/userlist_repository.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListDataSource userListDataSource;
  UserListRepositoryImpl({required this.userListDataSource});
  @override
  Future<Either<Failure, List<UserAppEntity>>> getUserList() async {
    List<UserAppEntity> userList = [];
    try {
      var data = await userListDataSource.getUserList();

      for (var userAppModel in data) {
        userList.add(userAppModel.toEntity());
      }
      return Right(userList);
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}
