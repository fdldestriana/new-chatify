part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthSignupRequested({required this.email, required this.password});
}

final class AuthSigninRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthSigninRequested({required this.email, required this.password});
}

final class AuthSignoutRequested extends AuthEvent {}
