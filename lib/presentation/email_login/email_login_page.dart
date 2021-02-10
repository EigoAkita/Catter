import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/file_path.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/email_login/email_login_model.dart';
import 'package:catter_app/presentation/email_login/widgets/login_text_button.dart';
import 'package:catter_app/presentation/email_login/widgets/login_text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class EmailLoginPage extends StatelessWidget {
  final imagePath = FilePath.imagePath;
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginButtonVariables = Variables.loginButtonVariables;

  final List _labelText = <String>[
    'メールアドレス',
    'パスワード',
  ];

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<EmailLoginModel>(
      create: (_) => EmailLoginModel(),
      child: Consumer<EmailLoginModel>(
        builder: (context, model, child) {
          return SizedBox(
            height: data.size.height,
            width: data.size.width,
            child: Scaffold(
              body: Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: <Widget>[
                      Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: <Widget>[
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Image.asset(
                                      '${imagePath}login_image.png',
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              loginTextFormWidget(
                                emailLoginModel: model,
                                isController: mailController,
                                isChange: true,
                                isErrorText: true,
                                labelText: _labelText[0],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              loginTextFormWidget(
                                emailLoginModel: model,
                                isController: passwordController,
                                isChange: false,
                                isErrorText: false,
                                labelText: _labelText[1],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: <Widget>[
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: Checkbox(
                                                  activeColor:
                                                      CustomColors.brownMain,
                                                  value:
                                                      model.isCheckTeamsOfUse,
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
                                                loginButtonVariables:
                                                    _loginButtonVariables[2]
                                                        ['value'],
                                                loginText: '利用規約',
                                                loginTextColor:
                                                    model.isCheckTeamsOfUse
                                                        ? CustomColors.whiteMain
                                                        : CustomColors.blueMain,
                                                isLoginTextFontSize: false,
                                                isLoginTextWeight: false,
                                                context: context,
                                              ),
                                              Text(
                                                'に同意する',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: model.isCheckTeamsOfUse
                                                      ? CustomColors.whiteMain
                                                      : CustomColors.grayMain,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        loginTextButtonWidget(
                                          emailLoginModel: model,
                                          loginButtonVariables:
                                              _loginButtonVariables[1]['value'],
                                          loginText: 'パスワードを忘れた方はこちら',
                                          loginTextColor: CustomColors.grayMain,
                                          isLoginTextFontSize: false,
                                          isLoginTextWeight: false,
                                          context: context,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
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
                                            'ログインする',
                                            style: TextStyle(
                                              color: CustomColors.whiteMain,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
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
                                        onPressed: model.isCheckTeamsOfUse
                                            ? () async {
                                                await model.login(
                                                    context: context);
                                                await Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BasePage(),
                                                  ),
                                                );
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
                              SizedBox(
                                height: 25,
                              ),
                              loginTextButtonWidget(
                                emailLoginModel: model,
                                loginButtonVariables: _loginButtonVariables[0]
                                    ['value'],
                                loginText: '新規登録はこちらから',
                                loginTextColor: CustomColors.whiteMain,
                                isLoginTextFontSize: true,
                                isLoginTextWeight: true,
                                context: context,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      model.isLoading
                          ? Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SizedBox(),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
