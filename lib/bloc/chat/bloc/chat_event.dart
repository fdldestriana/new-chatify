part of 'chat_bloc.dart';

sealed class ChatEvent {}

final class ChatCreateRequested extends ChatEvent {
  final String docId;
  final Message message;

  ChatCreateRequested({required this.docId, required this.message});
}
