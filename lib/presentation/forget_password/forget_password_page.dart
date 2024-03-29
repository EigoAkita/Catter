import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/convert_error_message.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/main_dialog.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/config/will_pop_scope.dart';
import 'package:catter_app/presentation/email_login/email_login_page.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'forget_password_model.dart';

class ForgetPasswordPage extends StatelessWidget {
  final useMailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: willPopCallback,
      child: ChangeNotifierProvider<ForgetPasswordModel>(
        create: (_) => ForgetPasswordModel(),
        child: Consumer<ForgetPasswordModel>(
          builder: (context, model, child) {
            return Stack(
              children: <Widget>[
                SizedBox(
                  height: data.size.height,
                  width: data.size.width,
                  child: Scaffold(
                    body: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Card(
                              shadowColor: CustomColors.grayMain,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: CustomColors.brownSub,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              1.15,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            ),
                                            Expanded(
                                              flex: 9,
                                              child: Text(
                                                'ご利用中のメールアドレス',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors.whiteMain,
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
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            ),
                                            Expanded(
                                              flex: 9,
                                              child: Neumorphic(
                                                style: const NeumorphicStyle(
                                                  shape: NeumorphicShape.flat,
                                                  depth: 1,
                                                  color: CustomColors.whiteMain,
                                                  shadowDarkColorEmboss:
                                                      Colors.blueGrey,
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      controller:
                                                          useMailController,
                                                      onChanged: (text) {
                                                        model.changeUseMail(
                                                            text);
                                                      },
                                                      obscureText: false,
                                                      maxLines: 1,
                                                      decoration:
                                                          InputDecoration(
                                                        errorText:
                                                            model.errorUseMail ==
                                                                    ''
                                                                ? null
                                                                : model
                                                                    .errorUseMail,
                                                        labelStyle: TextStyle(
                                                          color: CustomColors
                                                              .grayMain,
                                                        ),
                                                        filled: true,
                                                        fillColor: CustomColors
                                                            .whiteMain,
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'catter@example.com',
                                                      ),
                                                    ),
                                                  ],
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
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                          '再設定する',
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
                                        color: model.isUseMailValid
                                            ? CustomColors.brownMain
                                            : CustomColors.grayMain,
                                        border: NeumorphicBorder(
                                          color: CustomColors.whiteMain,
                                          width: 3,
                                        ),
                                      ),
                                      onPressed: model.isUseMailValid
                                          ? () async {
                                              model.startLoading();
                                              try {
                                                await model.sendResetEmail();
                                                mainDialog(
                                                  isOKOnly: false,
                                                  context: context,
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  dialogType:
                                                      DialogType.NO_HEADER,
                                                  dialogText:
                                                      'パスワード再設定用メール\nを送信しました。\nメールボックスをご確認ください。',
                                                  subOKText: 'はい',
                                                );
                                                model.endLoading();
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
                            SizedBox(
                              height: 15,
                            ),
                            FlatButton(
                              child: Text(
                                'ログイン画面に戻る',
                                style: TextStyle(
                                  color: CustomColors.whiteMain,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmailLoginPage(),
                                  ),
                                );
                              },
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
          },
        ),
      ),
    );
  }
}
