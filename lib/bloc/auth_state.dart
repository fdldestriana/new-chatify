part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccedState extends AuthState {
  final String email;

  AuthSuccedState({required this.email});
}

final class AuthFailedState extends AuthState {
  final String errorMessage;

  AuthFailedState({required this.errorMessage});
}
