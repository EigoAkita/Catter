import 'package:catter_app/config/convert_error_message.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailLoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String errorMail = '';
  String errorPassword = '';
  bool isLoading = false;
  bool isMailValid = false;
  bool isPasswordValid = false;
  bool isCheckTeamsOfUse = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkTeamsOfUse(bool isCheckTeamsOfUse) {
    this.isCheckTeamsOfUse = isCheckTeamsOfUse;
    notifyListeners();
  }

  Future login({@required BuildContext context}) async {
    try {
      startLoading();
      await _auth.signInWithEmailAndPassword(
        email: this.mail,
        password: this.password,
      );
    } catch (e) {
      errorShowDialog(
        loginErrorText: '${convertErrorMessage(e.code)}',
        context: context,
      );
      endLoading();
      print('エラーコード：${e.code}\nエラー：$e');
      throw (convertErrorMessage(e.code));
    }
  }

  void changeMail(text) {
    this.mail = text.trim();
    if (text.length == 0) {
      this.isMailValid = false;
      this.errorMail = 'メールアドレスを入力して下さい。';
    } else {
      this.isMailValid = true;
      this.errorMail = '';
    }
    notifyListeners();
  }

  void changePassword(text) {
    this.password = text;
    if (text.length == 0) {
      isPasswordValid = false;
      this.errorPassword = 'パスワードを入力して下さい。';
    } else if (text.length < 8 || text.length > 20) {
      isPasswordValid = false;
      this.errorPassword = 'パスワードは8文字以上20文字以内です。';
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
