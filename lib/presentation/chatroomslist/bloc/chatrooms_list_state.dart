part of 'chatrooms_list_bloc.dart';

sealed class ChatRoomsListState extends Equatable {
  const ChatRoomsListState();

  @override
  List<Object> get props => [];
}

final class ChatRoomsListInitial extends ChatRoomsListState {}

final class ChatRoomsListLoadingState extends ChatRoomsListState {}

final class ChatRoomsListLoadSucceedState extends ChatRoomsListState {
  final List<ChatRoomsListEntity> chatRoomsList;
  const ChatRoomsListLoadSucceedState({required this.chatRoomsList});
}

final class ChatRoomsListLoadFailedState extends ChatRoomsListState {
  final String errorMessage;
  const ChatRoomsListLoadFailedState({required this.errorMessage});
}
