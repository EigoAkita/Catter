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

  /// ログインしている自身のuidの取得
  String getUid() {
    final uid = _auth.currentUser.uid;

    return uid;
  }

  /// ログインしている自身の名前の取得
  String getDisplayName() {
    final displayName = _auth.currentUser.displayName;

    return displayName;
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
