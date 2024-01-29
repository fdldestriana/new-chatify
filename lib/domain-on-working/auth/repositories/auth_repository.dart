import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/domain-on-working/shared/entities/user_entitiy.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp(String email, String password);
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, Unit>> signOut();
}
