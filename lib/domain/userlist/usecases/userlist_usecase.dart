import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/userlist/repositories/userlist_repository.dart';

class UserListUseCase {
  final UserListRepository userListRepository;
  UserListUseCase({required this.userListRepository});

  Future<Either<Failure, List<UserAppEntity>>> call(NoParams params) async {
    return await userListRepository.getUserList();
  }
}
