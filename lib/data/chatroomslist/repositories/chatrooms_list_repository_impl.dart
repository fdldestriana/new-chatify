import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/chatroomslist/datasources/chatrooms_list_datasource.dart';
import 'package:new_chatify/domain/chatroomslist/entities/chatrooms_list_entity.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/chatrooms_list_repository.dart';

class ChatRoomsListRepositoryImpl implements ChatRoomsListRepository {
  final ChatRoomsListDataSource chatRoomsListDataSource;
  ChatRoomsListRepositoryImpl({required this.chatRoomsListDataSource});

  @override
  Future<Either<Failure, List<ChatRoomsListEntity>>> getChatRoomsList() async {
    @override
    List<ChatRoomsListEntity> chatRooms = [];
    try {
      var data = await chatRoomsListDataSource.getChatRoomsList();

      for (var chatRoomModel in data) {
        chatRooms.add(chatRoomModel.toEntity());
      }
      return Right(chatRooms);
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}
