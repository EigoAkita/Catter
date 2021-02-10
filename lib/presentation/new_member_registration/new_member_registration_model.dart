import 'package:catter_app/config/convert_error_message.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:catter_app/repository/firebase_auth.api.dart';
import 'package:catter_app/repository/firebase_firestore_api/uses_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMemberRegistrationModel extends ChangeNotifier {
  String mail = '';
  String password = '';
  String passwordConfirm = '';
  String errorMail = '';
  String errorPassword = '';
  String errorPasswordConfirm = '';
  bool isLoading = false;
  bool isMailValid = false;
  bool isPasswordValid = false;
  bool isPasswordConfirmValid = false;
  bool isCheckTeamsOfUse = false;
  UserCredential userCredential;
  static User currentUser;

  void checkTeamsOfUse(bool isCheckTeamsOfUse) {
    this.isCheckTeamsOfUse = isCheckTeamsOfUse;
    notifyListeners();
  }

  Future signUp({@required BuildContext context}) async {
    if (this.password != this.passwordConfirm) {
      throw (errorShowDialog(
        loginErrorText: 'パスワードが一致しません',
        context: context,
      ));
    }

    // 入力されたメール, パスワードで UserCredential を作成
    try {
      this.userCredential =
          await FirebaseAuthApi().registrationEmailAndPassword(
        mail: this.mail,
        password: this.password,
      );
      await UsersApi().setFirebaseUidAndCount(
        uid: this.userCredential.user.uid,
      );
      await UsersApi().setFirebaseEmail(
        uid: this.userCredential.user.uid,
        email: this.userCredential.user.email,
      );
    } catch (e) {
      print('エラーコード：${e.code}\nエラー：$e');
      throw (errorShowDialog(
        loginErrorText: convertErrorMessage(e.code),
        context: context,
      ));
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

  void changePasswordConfirm(text) {
    this.passwordConfirm = text;
    if (text.length == 0) {
      isPasswordConfirmValid = false;
      this.errorPasswordConfirm = 'パスワードを再入力して下さい。';
    } else if (text.length < 8 || text.length > 20) {
      isPasswordConfirmValid = false;
      this.errorPasswordConfirm = 'パスワードは8文字以上20文字以内です。';
    } else {
      isPasswordConfirmValid = true;
      this.errorPasswordConfirm = '';
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
