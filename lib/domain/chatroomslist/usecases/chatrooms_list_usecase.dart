import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/chatrooms_list_repository.dart';

class ChatRoomsListUseCase {
  final ChatRoomsListRepository chatRoomsListRepository;

  ChatRoomsListUseCase({required this.chatRoomsListRepository});

  Future<Either<Failure, List<UserAppEntity>>> call(NoParams params) async {
    return await chatRoomsListRepository.getChatRoomsList();
  }
}
