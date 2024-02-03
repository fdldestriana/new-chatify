import 'package:new_chatify/domain/shared/entities/message_entity.dart';

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
  final MessageEntity latestMessage;
  UserAppEntity(
      {required super.email, required this.uid, required this.latestMessage});
}
