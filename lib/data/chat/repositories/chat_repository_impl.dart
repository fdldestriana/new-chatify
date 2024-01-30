import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/chat/datasources/chat_datasource.dart';
import 'package:new_chatify/data/chat/models/message_model.dart';
import 'package:new_chatify/domain/chat/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatDataSource chatDataSource;
  ChatRepositoryImpl({required this.chatDataSource});

  @override
  Stream<Either<Failure, List<MessageModel>>> getMessages(String docId) async* {
    try {
      yield* chatDataSource.getMessages(docId).map((event) => Right(event));
    } catch (e) {
      yield Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      String docId, Map<String, dynamic> message) async {
    try {
      await chatDataSource.sendMessage(docId, message);
      return Right(Unit as Unit);
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }
}
