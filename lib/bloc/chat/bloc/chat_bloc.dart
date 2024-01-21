import 'package:bloc/bloc.dart';
import 'package:new_chatify/data/model/message.dart';
import 'package:new_chatify/service/chat_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService = ChatService();
  ChatBloc() : super(ChatInitial()) {
    on<ChatCreateRequested>((event, emit) async {
      try {
        await chatService.createChatRoom(
            docId: event.docId, message: event.message);
        emit(ChatCreateSucceedState());
      } catch (e) {
        emit(ChatCreateFailedState(errorMessage: e.toString()));
      }
    });
  }
}
