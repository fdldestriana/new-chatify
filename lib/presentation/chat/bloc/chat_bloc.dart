import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/domain/shared/entities/message_entity.dart';
import 'package:new_chatify/domain/chat/usecases/get_message_usecase.dart';
import 'package:new_chatify/domain/chat/usecases/send_message_usecase.dart';
import 'package:new_chatify/domain/chat/usecases/get_message_usecase.dart'
    as get_messages_usecase;
import 'package:new_chatify/domain/chat/usecases/send_message_usecase.dart'
    as send_message_usecase;
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  SendMessageUseCase sendMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  ChatBloc({required this.sendMessageUseCase, required this.getMessagesUseCase})
      : super(ChatInitial()) {
    on<ChatSendMessagesRequested>((event, emit) async {
      emit(ChatLoadingState());
      try {
        await sendMessageUseCase.call(
          send_message_usecase.Params(
            docId: event.docId,
            message: {
              "message": event.message.message,
              "receiverId": event.message.receiverId,
              "senderId": event.message.senderId,
              "timestamp": event.message.timestamp
            },
          ),
        );
        emit(ChatSendMessageSucceedState());
      } catch (e) {
        emit(ChatFailedState(errorMessage: e.toString()));
      }
    });

    on<ChatGetMessagesStarted>((event, emit) async {
      emit(ChatLoadingState());
      try {
        await emit.onEach(
          getMessagesUseCase.call(
            get_messages_usecase.Params(docId: event.docId),
          ),
          onData: (data) {
            data.fold(
              (l) => emit(
                ChatFailedState(errorMessage: l.errorMessage),
              ),
              (r) => add(
                ChatGetMessagesRequsted(messages: r),
              ),
            );
          },
        );
        emit(ChatGetMessagesCompleteState());
      } catch (e) {
        emit(ChatFailedState(errorMessage: e.toString()));
      }
    });

    on<ChatGetMessagesRequsted>((event, emit) {
      emit(ChatGetMessageSucceedState(messages: event.messages));
    });
  }
}
