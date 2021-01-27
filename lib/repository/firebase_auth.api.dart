import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ログインしている自身のuidの取得
  String getUid() {
    final uid = _auth.currentUser.uid;

    return uid;
  }

  // ログインしている自身の名前の取得
  String getDisplayName() {
    final displayName = _auth.currentUser.displayName;

    return displayName;
  }
}
