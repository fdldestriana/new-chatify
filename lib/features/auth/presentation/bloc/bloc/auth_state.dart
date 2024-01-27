part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSucceedState extends AuthState {
  final String email;

  const AuthSucceedState({required this.email});
}

final class AuthFailedState extends AuthState {
  final String errorMessage;

  const AuthFailedState({required this.errorMessage});
}

final class AuthSignoutSuccedState extends AuthState {}
