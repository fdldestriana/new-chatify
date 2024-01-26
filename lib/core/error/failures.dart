abstract class Failure {}

class InvalidEmailFailure extends Failure {}

class UserDisabledFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class EmailAlreadyInUseFailure extends Failure {}

class OperationNotAllowedFailure extends Failure {}

class WeakPasswordFailure extends Failure {}
