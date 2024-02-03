import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/exception.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/data/auth/datasources/auth_datasource.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/auth/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, UserAppEntity>> signIn(
      String email, String password) async {
    late UserAppModel data;
    try {
      data = await authDataSource.signIn(email, password);
    } catch (e) {
      switch (e) {
        case InvalidEmailException:
          return Left(InvalidEmailFailure(errorMessage: e.toString()));
        case UserDisabledException:
          return Left(UserDisabledFailure(errorMessage: e.toString()));
        case UserNotFoundException:
          return Left(UserNotFoundFailure(errorMessage: e.toString()));
        case WrongPasswordException:
          return Left(WrongPasswordFailure(errorMessage: e.toString()));
        default:
          return Left(UnknownFailure(errorMessage: e.toString()));
      }
    }
    return Right(data.toEntity());
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await authDataSource.signOut();
      return Right(Unit as Unit);
    } catch (e) {
      return Left(UnknownFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserAppEntity>> signUp(
      String email, String password) async {
    late UserAppModel data;
    try {
      data = await authDataSource.signUp(email, password);
    } catch (e) {
      switch (e) {
        case EmailAlreadyInUseException:
          return Left(EmailAlreadyInUseFailure(errorMessage: e.toString()));
        case InvalidEmailException:
          return Left(InvalidEmailFailure(errorMessage: e.toString()));
        case OperationNotAllowedException:
          return Left(OperationNotAllowedFailure(errorMessage: e.toString()));
        case WeakPasswordException:
          return Left(WeakPasswordFailure(errorMessage: e.toString()));
        default:
          return Left(UnknownFailure(errorMessage: e.toString()));
      }
    }
    return Right(data.toEntity());
  }
}
