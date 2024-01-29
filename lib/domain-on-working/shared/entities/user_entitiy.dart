// class UserEntity {
//   final String uid;
//   final String email;
//   final String password;

//   UserEntity(this.password, {required this.uid, required this.email});
// }

abstract class UserEntity {
  final String email;
  const UserEntity({required this.email});
}

class UserAuthEntity extends UserEntity {
  final String password;
  UserAuthEntity({required super.email, required this.password});
}

class UserAppEntity extends UserEntity {
  final String uid;
  UserAppEntity({required super.email, required this.uid});
}
