import 'package:catter_app/config/convert_error_message.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:catter_app/repository/firebase_firestore_api/uses_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NicknameRegistrationModel extends ChangeNotifier {
  bool isLoading = false;
  String nickname = '';
  bool isPasswordValid = false;
  String errorPassword = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registrationNickName({
    @required BuildContext context,
    @required String nickname,
  }) async {
    try {
      final uid = _auth.currentUser.uid;
      await UsersApi().registerNickname(
        uid: uid,
        nickname: nickname,
      );
    } catch (e) {
      print('エラーコード：${e.code}\nエラー：$e');
      throw (errorShowDialog(
        loginErrorText: convertErrorMessage(e.code),
        context: context,
      ));
    }
  }

  void changeNickName(text) {
    this.nickname = text;
    if (text.length == 0) {
      isPasswordValid = false;
      this.errorPassword = 'ニックネームを入力して下さい。';
    } else if (text.length > 6) {
      isPasswordValid = false;
      this.errorPassword = 'ニックネームは6文字以内です。';
    } else {
      isPasswordValid = true;
      this.errorPassword = '';
    }
    notifyListeners();
  }

  void startLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    this.isLoading = false;
    notifyListeners();
  }
}
