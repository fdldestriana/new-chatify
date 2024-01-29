part of 'userlist_bloc.dart';

sealed class UserlistState extends Equatable {
  const UserlistState();

  @override
  List<Object> get props => [];
}

final class UserlistInitial extends UserlistState {}

final class UserlistLoadingState extends UserlistState {}

final class UserlistLoadSucceedState extends UserlistState {
  final List<UserAppEntity> users;
  const UserlistLoadSucceedState({required this.users});
}

final class UserlistLoadFailedState extends UserlistState {
  final String errorMessage;
  const UserlistLoadFailedState({required this.errorMessage});
}
