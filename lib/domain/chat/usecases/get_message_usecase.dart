import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain/chat/entities/message_entity.dart';
import 'package:new_chatify/domain/chat/repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository chatRepository;
  GetMessagesUseCase({required this.chatRepository});

  Stream<Either<Failure, List<MessageEntity>>> call(Params params) async* {
    yield* chatRepository.getMessages(params.docId);
  }
}

class Params {
  final String docId;

  Params({required this.docId});
}
