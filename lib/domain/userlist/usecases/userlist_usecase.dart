import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/userlist/entities/userlist_item_entity.dart';
import 'package:new_chatify/domain/userlist/repositories/userlist_repository.dart';

class UserListUseCase extends UseCase<UserListItemEntity, NoParams> {
  final UserListRepository userListRepository;

  UserListUseCase({required this.userListRepository});

  @override
  Future<Either<Failure, UserListItemEntity>> call(NoParams params) async {
    return await userListRepository.getUserListItems();
  }
}
