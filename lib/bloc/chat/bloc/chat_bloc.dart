import 'package:bloc/bloc.dart';
import 'package:new_chatify/data/model/message.dart';
import 'package:new_chatify/service/chat_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService = ChatService();
  ChatBloc() : super(ChatGetMessageLoadingState()) {
    on<ChatSendMessagesRequested>((event, emit) async {
      try {
        await chatService.sendMessages(
            docId: event.docId, message: event.message);
        emit(ChatSendMessageSucceedState());
      } catch (e) {
        emit(ChatSendFailedState(errorMessage: e.toString()));
      }
    });

    on<ChatGetMessagesRequested>((event, emit) async {
      try {
        var messages = await chatService.getMessages(docId: event.docId).first;
        emit(ChatGetMessageSucceedState(messages: messages));
      } catch (e) {
        emit(ChatGetFailedState(errorMessage: e.toString()));
      }
    });
  }
}
