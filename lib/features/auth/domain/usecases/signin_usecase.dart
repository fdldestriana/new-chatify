import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/features/auth/domain/entities/user_entitiy.dart';
import 'package:new_chatify/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase extends UseCase<UserEntity, Params> {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(Params params) async {
    return await authRepository.signIn(params.email, params.password);
  }
}

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});
}
