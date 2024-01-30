// import 'package:bloc/bloc.dart';
// import 'package:new_chatify/data/model/message.dart';
// import 'package:new_chatify/data/service/chat_service.dart';
// part 'chat_event.dart';
// part 'chat_state.dart';

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final ChatService chatService = ChatService();
//   ChatBloc() : super(ChatInitial()) {
//     on<ChatSendMessagesRequested>((event, emit) async {
//       emit(ChatLoadingState());
//       try {
//         await chatService.sendMessages(
//             docId: event.docId, message: event.message);
//         emit(ChatSendMessageSucceedState());
//       } catch (e) {
//         emit(ChatFailedState(errorMessage: e.toString()));
//       }
//     });

//     on<ChatGetMessagesStarted>((event, emit) async {
//       emit(ChatLoadingState());
//       try {
//         await emit.onEach(
//           chatService.getMessages(docId: event.docId),
//           onData: (data) => add(ChatGetMessagesRequsted(messages: data)),
//         );
//         emit(ChatGetMessagesCompleteState());
//       } catch (e) {
//         emit(ChatFailedState(errorMessage: e.toString()));
//       }
//     });

//     on<ChatGetMessagesRequsted>((event, emit) {
//       emit(ChatGetMessageSucceedState(messages: event.messages));
//     });
//   }
// }
