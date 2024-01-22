part of 'chat_bloc.dart';

sealed class ChatEvent {}

final class ChatSendMessagesRequested extends ChatEvent {
  final String docId;
  final Message message;

  ChatSendMessagesRequested({required this.docId, required this.message});
}

final class ChatGetMessagesRequested extends ChatEvent {
  final String docId;

  ChatGetMessagesRequested({required this.docId});
}
