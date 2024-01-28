class InvalidEmailException implements Exception {
  final String errorMessage;
  InvalidEmailException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class UserDisabledException implements Exception {
  final String errorMessage;
  UserDisabledException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class UserNotFoundException implements Exception {
  final String errorMessage;
  UserNotFoundException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class WrongPasswordException implements Exception {
  final String errorMessage;
  WrongPasswordException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class EmailAlreadyInUseException implements Exception {
  final String errorMessage;
  EmailAlreadyInUseException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class OperationNotAllowedException implements Exception {
  final String errorMessage;
  OperationNotAllowedException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class WeakPasswordException implements Exception {
  final String errorMessage;
  WeakPasswordException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class UnknownException implements Exception {
  final String errorMessage;
  UnknownException({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}
