import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:new_chatify/service/auth_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<AuthSignupRequested>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final userCred = await authService.signUp(
            email: event.email, password: event.password);
        emit(AuthSucceedState(email: userCred!.user!.email.toString()));
      } catch (e) {
        emit(AuthFailedState(errorMessage: e.toString()));
      }
    });

    on<AuthSigninRequested>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final userCred = await authService.signIn(
            email: event.email, password: event.password);
        emit(AuthSucceedState(email: userCred!.user!.email.toString()));
      } catch (e) {
        emit(AuthFailedState(errorMessage: e.toString()));
      }
    });

    on<AuthSignoutRequested>((event, emit) async {
      try {
        emit(AuthLoadingState());
        await authService.signOut();
        emit(AuthSignoutSuccedState());
      } catch (e) {
        emit(AuthFailedState(errorMessage: e.toString()));
      }
    });
  }
}
