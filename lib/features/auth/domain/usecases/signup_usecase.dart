import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/features/auth/domain/entities/user_entitiy.dart';
import 'package:new_chatify/features/auth/domain/repositories/auth_repository.dart';

class SignUp extends UseCase<UserEntity, Params> {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(Params params) async {
    return await authRepository.signUp(params.email, params.password);
  }
}

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});
}
