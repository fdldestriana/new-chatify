import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/features/auth/data/datasources/auth_datasource.dart';
import 'package:new_chatify/features/auth/domain/entities/user_entitiy.dart';
import 'package:new_chatify/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, UserEntity>> signIn(
      String email, String password) async {
    try {
      await authDataSource.signIn(email, password);
      return Right(_r);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return Left(InvalidEmailFailure());
      } else if (e.code == "user-disabled") {
        return Left(UserDisabledFailure());
      } else if (e.code == "user-not-found") {
        return Left(UserNotFoundFailure());
      } else if (e.code == "wrong-password") {
        return Left(WrongPasswordFailure());
      }
    } catch (e) {
      return Left(_l);
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {} on FirebaseAuthException {
    } catch (e) {}
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
      String email, String password) async {
    try {
      await authDataSource.signUp(email, password);
      return Right(_r);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return Left(EmailAlreadyInUseFailure());
      } else if (e.code == "invalid-email") {
        return Left(InvalidEmailFailure());
      } else if (e.code == "operation-not-allowed:") {
        return Left(OperationNotAllowedFailure());
      } else if (e.code == "weak-password") {
        return Left(WeakPasswordFailure());
      }
    } catch (e) {
      return Left(_l);
    }
  }
}
