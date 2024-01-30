part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

final class ChatSendMessagesRequested extends ChatEvent {
  final String docId;
  final MessageEntity message;

  const ChatSendMessagesRequested({required this.docId, required this.message});
}

final class ChatGetMessagesStarted extends ChatEvent {
  final String docId;
  const ChatGetMessagesStarted({required this.docId});
}

final class ChatGetMessagesRequsted extends ChatEvent {
  final List<MessageEntity> messages;
  const ChatGetMessagesRequsted({required this.messages});
}
