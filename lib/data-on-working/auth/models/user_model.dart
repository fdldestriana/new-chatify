import 'package:new_chatify/domain-on-working/shared/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  @override
  UserModel(
      {required String uid, required String email, required String password})
      : super(uid: uid, email: email, password: password);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"],
      email: map["email"],
      password: map["password"],
    );
  }
  UserEntity toEntity() {
    return UserEntity(uid: uid, email: email, password: password);
  }
}
