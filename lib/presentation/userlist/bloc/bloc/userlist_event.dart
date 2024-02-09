part of 'userlist_bloc.dart';

sealed class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

final class UserListLoadRequested extends UserListEvent {}
