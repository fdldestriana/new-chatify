import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain-on-working/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain-on-working/auth/repositories/auth_repository.dart';

class SignUpUseCase extends UseCase<UserEntity, Params> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

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
