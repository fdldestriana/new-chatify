part of 'chat_bloc.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSendMessageSucceedState extends ChatState {}

final class ChatSendFailedState extends ChatState {
  final String errorMessage;
  ChatSendFailedState({required this.errorMessage});
}

final class ChatGetMessageLoadingState extends ChatState {}

final class ChatGetMessageSucceedState extends ChatState {
  List<Message> messages;
  ChatGetMessageSucceedState({required this.messages});
}

final class ChatGetFailedState extends ChatState {
  final String errorMessage;
  ChatGetFailedState({required this.errorMessage});
}
