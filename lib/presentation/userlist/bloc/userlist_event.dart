part of 'userlist_bloc.dart';

sealed class UserlistEvent extends Equatable {
  const UserlistEvent();

  @override
  List<Object> get props => [];
}

final class UsersListItemLoadRequested extends UserlistEvent {}
