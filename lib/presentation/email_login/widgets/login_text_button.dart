import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/forget_password/forget_password_page.dart';
import 'package:catter_app/presentation/new_member_registration/new_member_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'error_show_dialog.dart';

final List variables = Variables.loginButtonVariables;

Widget loginTextButtonWidget({
  @required emailLoginModel,
  @required Object loginButtonVariables,
  @required String loginText,
  @required Color loginTextColor,
  @required bool isLoginTextFontSize,
  @required bool isLoginTextWeight,
  @required bool underLine,
  @required BuildContext context,
}) {
  return GestureDetector(
    onTap: () async {
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
        const teamsOfServiceURL =
            'https://kiyac.app/termsOfService/RnJ1enYAKSz3isHCTNWv';
        if (await canLaunch(teamsOfServiceURL)) {
          await launch(teamsOfServiceURL);
        } else {
          errorShowDialog(
            loginErrorText: 'エラーが発生しました',
            context: context,
          );
        }
      }

      ///プライバシーポリシーを読む
      if (loginButtonVariables == variables[3]['value']) {
        const teamsOfServiceURL =
            'https://kiyac.app/plivacypolicy/77AoBVZzhnrpfVvvMHN4';
        if (await canLaunch(teamsOfServiceURL)) {
          await launch(teamsOfServiceURL);
        } else {
          errorShowDialog(
            loginErrorText: 'エラーが発生しました',
            context: context,
          );
        }
      }
    },
    child: Text(
      '$loginText',
      style: TextStyle(
        color: loginTextColor,
        fontSize: isLoginTextFontSize ? 15 : 10,
        fontWeight: isLoginTextWeight ? FontWeight.bold : null,
        decoration: underLine ? TextDecoration.underline : null,
      ),
    ),
  );
}
