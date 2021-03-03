import 'package:catter_app/config/convert_error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordModel extends ChangeNotifier {
  String useMail = '';
  String errorUseMail = '';
  bool isLoading = false;
  bool isUseMailValid = false;

  Future sendResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email:
        useMail,
      );
    } catch (e) {
      print('${e.code}: $e');
      throw (convertErrorMessage(e.code));
    }
  }

  void changeUseMail(text) {
    this.useMail = text.trim();
    if (text.length == 0) {
      this.isUseMailValid = false;
      this.errorUseMail = 'メールアドレスを入力して下さい。';
    } else {
      this.isUseMailValid = true;
      this.errorUseMail = '';
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
