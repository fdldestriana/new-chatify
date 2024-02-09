import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain/chatroomslist/entities/chatrooms_list_entity.dart';

abstract class ChatRoomsListRepository {
  Future<Either<Failure, List<ChatRoomsListEntity>>> getChatRoomsList();
}
