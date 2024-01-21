part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitialState extends UserState {}

final class UsersLoadSucceedState extends UserState {
  final List<UserApp> users;
  UsersLoadSucceedState({required this.users});
}

final class UserLoadingState extends UserState {}

final class UserLoadFailedState extends UserState {
  final String errorMessage;
  UserLoadFailedState({required this.errorMessage});
}
