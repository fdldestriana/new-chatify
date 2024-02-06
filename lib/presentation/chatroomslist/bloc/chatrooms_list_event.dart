part of 'chatrooms_list_bloc.dart';

sealed class ChatRoomsListEvent extends Equatable {
  const ChatRoomsListEvent();

  @override
  List<Object> get props => [];
}

final class ChatRoomsListLoadRequested extends ChatRoomsListEvent {}
