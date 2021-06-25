import 'package:catter_app/config/convert_error_message.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:catter_app/presentation/email_login/widgets/login_text_button.dart';
import 'package:catter_app/presentation/new_member_registration/new_member_registration_model.dart';
import 'package:catter_app/presentation/new_member_registration/widgets/input_form_template.dart';
import 'package:catter_app/presentation/nickname_registration/nickname_registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class NewMemberRegistrationPage extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginButtonVariables = Variables.loginButtonVariables;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<NewMemberRegistrationModel>(
      create: (_) => NewMemberRegistrationModel(),
      child: Consumer<NewMemberRegistrationModel>(
          builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    '新規登録',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: CustomColors.brownMain,
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        inputFormTemplate(
                          model: model,
                          context: context,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: Checkbox(
                                activeColor: CustomColors.brownMain,
                                value: model.isCheckTeamsOfUse,
                                onChanged: (bool) {
                                  model.checkTeamsOfUse(bool);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            loginTextButtonWidget(
                              emailLoginModel: model,
                              loginButtonVariables: _loginButtonVariables[2]
                                  ['value'],
                              loginText: '利用規約',
                              loginTextColor: model.isCheckTeamsOfUse
                                  ? CustomColors.whiteMain
                                  : CustomColors.pinkMain,
                              isLoginTextFontSize: true,
                              isLoginTextWeight: false,
                              context: context,
                              underLine: true,
                            ),
                            Text(
                              'に同意する',
                              style: TextStyle(
                                fontSize: 15,
                                color: model.isCheckTeamsOfUse
                                    ? CustomColors.whiteMain
                                    : CustomColors.graySub,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            loginTextButtonWidget(
                              emailLoginModel: model,
                              loginButtonVariables: _loginButtonVariables[3]
                                  ['value'],
                              loginText: 'プライバシーポリシー',
                              loginTextColor: CustomColors.pinkMain,
                              isLoginTextFontSize: true,
                              isLoginTextWeight: false,
                              context: context,
                              underLine: true,
                            ),
                            Text(
                              'を読む',
                              style: TextStyle(
                                fontSize: 15,
                                color: CustomColors.whiteMain,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                height: 60,
                                child: NeumorphicButton(
                                  child: Center(
                                    child: const Text(
                                      '次へ',
                                      style: TextStyle(
                                        color: CustomColors.whiteMain,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(15),
                                    ),
                                    color: model.isCheckTeamsOfUse
                                        ? CustomColors.brownMain
                                        : CustomColors.grayMain,
                                    border: NeumorphicBorder(
                                      color: CustomColors.whiteMain,
                                      width: 3,
                                    ),
                                  ),
                                  onPressed: model.isCheckTeamsOfUse &&
                                          model.isMailValid &&
                                          model.isPasswordValid &&
                                          model.isPasswordConfirmValid
                                      ? () async {
                                          model.startLoading();
                                          try {
                                            await model.signUp(
                                                context: context);
                                            model.endLoading();
                                            await Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NicknameRegistrationPage(),
                                              ),
                                            );
                                          } catch (e) {
                                            errorShowDialog(
                                              loginErrorText:
                                                  convertErrorMessage(
                                                e.toString(),
                                              ),
                                              context: context,
                                            );
                                            model.endLoading();
                                          }
                                        }
                                      : null,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            screenLoading(
              isLoading: model.isLoading,
            ),
          ],
        );
      }),
    );
  }
}
