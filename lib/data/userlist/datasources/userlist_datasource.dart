import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';

abstract class UserListDataSource {
  Future<List<UserAppModel>> getUserList();
}

class UserListDataSourceImpl implements UserListDataSource {
  List<UserAppModel> userList = [];
  @override
  Future<List<UserAppModel>> getUserList() async {
    try {
      await FirebaseFirestore.instance.collection("users").get().then((value) {
        var docs = value.docs;
        userList = docs.map((e) {
          return UserAppModel.fromMap(e.data());
        }).toList();
      }).onError(
        (e, _) => throw Exception(e.toString()),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
    return userList;
  }
}
