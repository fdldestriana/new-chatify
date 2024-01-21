part of 'chat_bloc.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatCreateSucceedState extends ChatState {}

final class ChatCreateFailedState extends ChatState {
  final String errorMessage;
  ChatCreateFailedState({required this.errorMessage});
}
