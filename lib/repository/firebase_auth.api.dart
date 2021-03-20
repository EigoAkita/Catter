import 'package:catter_app/presentation/new_member_registration/new_member_registration_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isSignIn() async {
    if (_auth.currentUser != null) {
      NewMemberRegistrationModel.currentUser = _auth.currentUser;
      return true;
    } else {
      return false;
    }
  }

  /// emailとpasswordを登録する
  Future<UserCredential> registrationEmailAndPassword({
    @required mail,
    @required password,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );

    return result;
  }
}
