abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure({required super.errorMessage});
}

class UserDisabledFailure extends Failure {
  UserDisabledFailure({required super.errorMessage});
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({required super.errorMessage});
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure({required super.errorMessage});
}

class EmailAlreadyInUseFailure extends Failure {
  EmailAlreadyInUseFailure({required super.errorMessage});
}

class OperationNotAllowedFailure extends Failure {
  OperationNotAllowedFailure({required super.errorMessage});
}

class WeakPasswordFailure extends Failure {
  WeakPasswordFailure({required super.errorMessage});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.errorMessage});
}
