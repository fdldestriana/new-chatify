part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatSendMessageSucceedState extends ChatState {}

final class ChatGetMessagesCompleteState extends ChatState {}

final class ChatGetMessageSucceedState extends ChatState {
  final List<MessageEntity> messages;
  const ChatGetMessageSucceedState({required this.messages});
}

final class ChatFailedState extends ChatState {
  final String errorMessage;
  const ChatFailedState({required this.errorMessage});
}
