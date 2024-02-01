import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/userlist/datasources/userlist_datasource.dart';
import 'package:new_chatify/domain/userlist/entities/userlist_item_entity.dart';
import 'package:new_chatify/domain/userlist/repositories/userlist_repository.dart';

class UserListRepositoryImpl implements UserListRepository {
  final UserListDataSource userListDataSource;
  UserListRepositoryImpl({required this.userListDataSource});

  @override
  Future<Either<Failure, UserListItemEntity>> getUserListItems() async {
    try {
      return Right(await userListDataSource
          .getUserListItems()
          .then((value) => value.toEntity()));
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, List<UserAppEntity>>> getUsers() async {
  //   List<UserAppEntity> users = [];
  //   try {
  //     List<UserAppModel> data = await userListDataSource.getUsers();
  //     for (UserAppModel user in data) {
  //       users.add(user.toEntity());
  //     }
  //   } catch (e) {
  //     return Left(UnknownFailure(errorMessage: e.toString()));
  //   }
  //   return Right(users);
  // }
}
