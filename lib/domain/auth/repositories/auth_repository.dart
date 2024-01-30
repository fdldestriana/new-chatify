import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserAppEntity>> signUp(String email, String password);
  Future<Either<Failure, UserAppEntity>> signIn(String email, String password);
  Future<Either<Failure, Unit>> signOut();
}
