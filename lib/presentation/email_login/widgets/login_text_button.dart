import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/forget_password/forget_password_page.dart';
import 'package:catter_app/presentation/new_member_registration/new_member_registration_page.dart';
import 'package:flutter/material.dart';

final List variables = Variables.loginButtonVariables;

Widget loginTextButtonWidget({
  @required emailLoginModel,
  @required Object loginButtonVariables,
  @required String loginText,
  @required Color loginTextColor,
  @required bool isLoginTextFontSize,
  @required bool isLoginTextWeight,
  @required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      ///新規登録はこちら
      if (loginButtonVariables == variables[0]['value']) {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => NewMemberRegistrationPage(),
          ),
        );
      }
      ///パスワードを忘れた方はこちら
      if (loginButtonVariables == variables[1]['value']) {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => ForgetPasswordPage(),
          ),
        );
      }
      ///利用規約に同意する
      if (loginButtonVariables == variables[2]['value']) {
        ///利用規約のページに遷移させる処理を書く
      }
    },
    child: Text(
      '$loginText',
      style: TextStyle(
        color: loginTextColor,
        fontSize: isLoginTextFontSize ? 15 : 10,
        fontWeight: isLoginTextWeight ? FontWeight.bold : null,
      ),
    ),
  );
}
