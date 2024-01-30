import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain-on-working/chat/repositories/chat_repository.dart';

class SendMessageUseCase extends UseCase<Unit, Params> {
  final ChatRepository chatRepository;
  SendMessageUseCase({required this.chatRepository});

  @override
  Future<Either<Failure, Unit>> call(Params params) async {
    return await chatRepository.sendMessage(params.docId, params.message);
  }
}

class Params {
  final String docId;
  final Map<String, dynamic> message;

  Params({required this.docId, required this.message});
}
