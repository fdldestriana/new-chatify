import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';
import 'package:new_chatify/domain/auth/repositories/auth_repository.dart';

class SignUpUseCase extends UseCase<UserAppEntity, Params> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserAppEntity>> call(Params params) async {
    return await authRepository.signUp(params.email, params.password);
  }
}

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});
}
