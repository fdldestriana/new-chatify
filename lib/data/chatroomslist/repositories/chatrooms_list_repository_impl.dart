import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/chatroomslist/datasources/chatrooms_list_datasource.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/chatroomslist/repositories/chatrooms_list_repository.dart';

class ChatRoomsListRepositoryImpl implements ChatRoomsListRepository {
  final ChatRoomsListDataSource chatRoomsListDataSource;
  ChatRoomsListRepositoryImpl({required this.chatRoomsListDataSource});

  @override
  Future<Either<Failure, List<UserAppEntity>>> getChatRoomsList() async {
    @override
    List<UserAppEntity> users = [];
    try {
      List<UserAppModel> data = await chatRoomsListDataSource.getUserList();
      for (UserAppModel user in data) {
        users.add(user.toEntity());
      }
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
    return Right(users);
  }
}
