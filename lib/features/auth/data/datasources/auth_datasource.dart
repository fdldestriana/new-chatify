import 'package:new_chatify/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signUp(String email, String password);
  Future<UserModel> signIn(String email, String password);
  Future<void> signOut();
}
