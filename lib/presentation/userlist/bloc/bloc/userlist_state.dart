part of 'userlist_bloc.dart';

sealed class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object> get props => [];
}

final class UserListInitial extends UserListState {}

final class UserListLoadingState extends UserListState {}

final class UserListLoadSucceedState extends UserListState {
  final List<UserAppEntity> userList;
  const UserListLoadSucceedState({required this.userList});
}

final class UserListLoadFailedState extends UserListState {
  final String errorMessage;
  const UserListLoadFailedState({required this.errorMessage});
}
