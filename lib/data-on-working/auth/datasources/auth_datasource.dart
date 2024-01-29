import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_chatify/core/error/exception.dart';
import 'package:new_chatify/data-on-working/shared/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserAppModel> signUp(String email, String password);
  Future<UserAppModel> signIn(String email, String password);
  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<UserAppModel> signIn(String email, String password) async {
    late UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseFirestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email
      }, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          throw InvalidEmailException(errorMessage: "The email is invalid");
        case "user-disabled":
          throw UserDisabledException(errorMessage: "The user is disabled");
        case "user-not-found":
          throw UserNotFoundException(errorMessage: "The user is not found");
        case "wrong-password":
          throw WrongPasswordException(errorMessage: "The password is wrong");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return UserAppModel.fromMap(
      {
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
      },
    );
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserAppModel> signUp(String email, String password) async {
    late UserCredential userCredential;
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseFirestore.collection("users").doc(userCredential.user!.uid).set(
        {"uid": userCredential.user!.uid, "email": userCredential.user!.email},
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw EmailAlreadyInUseException(
              errorMessage: "The email was used for another user");
        case "invalid-email":
          throw InvalidEmailException(errorMessage: "Email is invalid");
        case "operation-not-allowed:":
          throw OperationNotAllowedException(
              errorMessage: "This requested is not allowed");
        case "weak-password":
          throw WeakPasswordException(errorMessage: "Password is weak");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return UserAppModel.fromMap(
      {
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
      },
    );
  }
}
