import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email
      });

      return userCredential;
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

  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email
      }, SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        throw Exception("The email is invalid");
      } else if (e.code == "user-disabled") {
        throw Exception("The user is disabled");
      } else if (e.code == "user-not-found") {
        throw Exception("The user is not found");
      } else if (e.code == "wrong-password") {
        throw Exception("The password is wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
