import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/chatrooms_list_repository.dart';

class ChatRoomsListUseCase extends UseCase<List<UserAppEntity>, NoParams> {
  final ChatRoomsListRepository userListRepository;

  ChatRoomsListUseCase({required this.userListRepository});

  @override
  Future<Either<Failure, List<UserAppEntity>>> call(NoParams params) async {
    return await userListRepository.getUserList();
  }
}
