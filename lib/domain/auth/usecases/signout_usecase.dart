import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';
import 'package:new_chatify/core/usecases/usecase.dart';
import 'package:new_chatify/domain/auth/repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<Unit, NoParams> {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
