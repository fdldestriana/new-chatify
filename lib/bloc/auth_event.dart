part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignupRequested extends AuthEvent {
  final String email;
  final String password;
  AuthSignupRequested({required this.email, required this.password});
}

final class AuthSigninRequested extends AuthEvent {
  final String email;
  final String password;
  AuthSigninRequested({required this.email, required this.password});
}

final class AuthSignoutRequested extends AuthEvent {}
