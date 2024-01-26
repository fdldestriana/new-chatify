import 'package:dartz/dartz.dart';
import 'package:new_chatify/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
