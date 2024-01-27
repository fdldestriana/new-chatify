import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/features/auth/domain/entities/user_entitiy.dart';
import 'package:new_chatify/features/auth/domain/usecases/signin_usecase.dart';
import 'package:new_chatify/features/auth/domain/usecases/signout_usecase.dart';
import 'package:new_chatify/features/auth/domain/usecases/signup_usecase.dart';
import 'package:new_chatify/features/auth/domain/usecases/signup_usecase.dart'
    as signup_usecase;
import 'package:new_chatify/features/auth/domain/usecases/signin_usecase.dart'
    as signin_usecase;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc(this.signUpUseCase, this.signInUseCase, this.signOutUseCase)
      : super(AuthInitial()) {
    on<AuthSignupRequested>(
      (event, emit) async {
        emit(AuthLoadingState());
        Either<Failure, UserEntity> userCred = await signUpUseCase.call(
          signup_usecase.Params(email: event.email, password: event.password),
        );
        userCred.fold(
            (l) => emit(const AuthFailedState(errorMessage: "errorMessage")),
            (r) => emit(AuthSucceedState(email: r.email)));
      },
    );

    on<AuthSigninRequested>(
      (event, emit) async {
        emit(AuthLoadingState());
        Either<Failure, UserEntity> userCred = await signInUseCase.call(
          signin_usecase.Params(email: event.email, password: event.password),
        );
        userCred.fold(
            (l) => emit(const AuthFailedState(errorMessage: "errorMessage")),
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
