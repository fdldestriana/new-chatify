import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/userlist_repository.dart';

class UserListUseCase extends UseCase<List<UserAppEntity>, NoParams> {
  final UserListRepository userListRepository;

  UserListUseCase({required this.userListRepository});

  @override
  Future<Either<Failure, List<UserAppEntity>>> call(NoParams params) async {
    return await userListRepository.getUserList();
  }
}
