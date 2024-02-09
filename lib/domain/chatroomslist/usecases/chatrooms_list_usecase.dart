import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/chatroomslist/entities/chatrooms_list_entity.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/chatrooms_list_repository.dart';

class ChatRoomsListUseCase {
  final ChatRoomsListRepository chatRoomsListRepository;

  ChatRoomsListUseCase({required this.chatRoomsListRepository});

  Future<Either<Failure, List<ChatRoomsListEntity>>> call(
      NoParams params) async {
    return await chatRoomsListRepository.getChatRoomsList();
  }
}
