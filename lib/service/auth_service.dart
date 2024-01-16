import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        throw Exception("The email was used for another user");
      } else if (e.code == "invalid-email") {
        throw Exception("Email is invalid");
      } else if (e.code == "operation-not-allowed:") {
        throw Exception("This requested is not allowed");
      } else if (e.code == "weak-password") {
        throw Exception("Password is weak");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
