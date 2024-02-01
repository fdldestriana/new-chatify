import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain/shared/entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Unit>> sendMessage(
      String docId, Map<String, dynamic> message);
  Stream<Either<Failure, List<MessageEntity>>> getMessages(String docId);
}
