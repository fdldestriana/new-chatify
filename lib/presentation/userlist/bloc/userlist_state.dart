part of 'userlist_bloc.dart';

sealed class UserlistState extends Equatable {
  const UserlistState();

  @override
  List<Object> get props => [];
}

final class UserlistInitial extends UserlistState {}

final class UserlistItemLoadingState extends UserlistState {}

final class UserlistItemLoadSucceedState extends UserlistState {
  final UserListItemEntity userlistItemEntity;
  const UserlistItemLoadSucceedState({required this.userlistItemEntity});
}

final class UserlistItemLoadFailedState extends UserlistState {
  final String errorMessage;
  const UserlistItemLoadFailedState({required this.errorMessage});
}
