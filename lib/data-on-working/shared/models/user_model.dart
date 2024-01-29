import 'package:new_chatify/domain-on-working/shared/entities/user_entitiy.dart';

class UserAuthModel extends UserAuthEntity {
  UserAuthModel({required super.email, required super.password});
}

class UserAppModel extends UserAppEntity {
  UserAppModel({required super.email, required super.uid});

  factory UserAppModel.fromMap(Map<String, dynamic> map) {
    return UserAppModel(email: map["email"], uid: map["uid"]);
  }

  UserAppEntity toEntity() {
    return UserAppEntity(email: email, uid: uid);
  }
}
