import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_chatify/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignupRequested>((event, emit) async {
      try {
        emit(AuthLoadingState());
        final userCred = await AuthService.signUp(
            email: event.email, password: event.password);
        emit(AuthSuccedState(email: userCred!.user!.email.toString()));
      } catch (e) {
        emit(AuthFailedState(errorMessage: e.toString()));
      }
    });

    on<AuthSigninRequested>((event, emit) async {});
  }
}