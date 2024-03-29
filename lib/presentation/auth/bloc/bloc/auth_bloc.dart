import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/auth/usecases/signin_usecase.dart';
import 'package:new_chatify/domain/auth/usecases/signout_usecase.dart';
import 'package:new_chatify/domain/auth/usecases/signup_usecase.dart';
import 'package:new_chatify/domain/auth/usecases/signup_usecase.dart'
    as signup_usecase;
import 'package:new_chatify/domain/auth/usecases/signin_usecase.dart'
    as signin_usecase;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc(
      {required this.signUpUseCase,
      required this.signInUseCase,
      required this.signOutUseCase})
      : super(AuthInitial()) {
    on<AuthSignupRequested>(
      (event, emit) async {
        emit(AuthLoadingState());
        Either<Failure, UserAppEntity> userCred = await signUpUseCase.call(
          signup_usecase.Params(email: event.email, password: event.password),
        );
        userCred.fold(
            (l) => emit(AuthFailedState(errorMessage: l.errorMessage)),
            (r) => emit(AuthSucceedState(email: r.email)));
      },
    );

    on<AuthSigninRequested>(
      (event, emit) async {
        emit(AuthLoadingState());
        Either<Failure, UserAppEntity> userCred = await signInUseCase.call(
          signin_usecase.Params(email: event.email, password: event.password),
        );
        userCred.fold(
            (l) => emit(AuthFailedState(errorMessage: l.errorMessage)),
            (r) => emit(AuthSucceedState(email: r.email)));
      },
    );

    on<AuthSignoutRequested>(
      (event, emit) async {
        await signOutUseCase.call(NoParams());
      },
    );
  }
}
