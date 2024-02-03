import 'package:new_chatify/data/shared/models/message_model.dart';
import 'package:new_chatify/domain/shared/entities/user_entitiy.dart';

class UserAuthModel extends UserAuthEntity {
  UserAuthModel({required super.email, required super.password});
}

class UserAppModel extends UserAppEntity {
  UserAppModel(
      {required super.email, required super.uid, required super.latestMessage});

  factory UserAppModel.fromMap(Map<String, dynamic> map) {
    return UserAppModel(
      email: map["email"],
      uid: map["uid"],
      latestMessage: MessageModel.fromMap(map["latestMessage"]),
    );
  }

  UserAppEntity toEntity() {
    return UserAppEntity(email: email, uid: uid, latestMessage: latestMessage);
  }
}
