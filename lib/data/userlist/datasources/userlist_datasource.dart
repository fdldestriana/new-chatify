import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/data/shared/models/user_app_model.dart';

abstract class UserListDataSource {
  Future<List<UserAppModel>> getUserList();
}

class UserListDataSourceImpl implements UserListDataSource {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");
  List<UserAppModel> _userList = [];
  @override
  Future<List<UserAppModel>> getUserList() async {
    await _users.get().then(
      (value) {
        final docs = value.docs;
        _userList = docs
            .where((doc) => doc.id != FirebaseAuth.instance.currentUser!.uid)
            .map(
          (doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return UserAppModel.fromMap(data);
          },
        ).toList();
      },
      onError: (e) {
        throw Exception(e.toString());
      },
    );
    return _userList;
  }
}
