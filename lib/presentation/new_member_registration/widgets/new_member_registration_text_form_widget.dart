import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/new_member_registration/new_member_registration_model.dart';
import 'package:catter_app/presentation/nickname_registration/nickname_registration_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final List variables = Variables.inputFormTemplateInRegistrationVariables;

Widget newMemberRegistrationTextFormWidget({
  NewMemberRegistrationModel memberModel,
  NicknameRegistrationModel nicknameModel,
  @required bool visible,
  @required errorTextModel,
  @required dynamic isController,
  @required Object inputFormTemplateInRegistrationVariables,
  @required String inputFormText,
  @required BuildContext context,
  @required bool obscureText,
  @required bool isHintText,
}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width / 1.15,
    ),
    child: Column(
      children: <Widget>[
        Visibility(
          visible: visible,
          child: Row(
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 9,
                child: Text(
                  '$inputFormText',
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
        ),
        Visibility(
          visible: visible,
          child: SizedBox(
            height: 10,
          ),
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
                  shadowDarkColorEmboss: Colors.blueGrey,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 2,
                    ),
                    TextFormField(
                      controller: isController,
                      onChanged: (text) {
                        ///メールアドレス
                        if (inputFormTemplateInRegistrationVariables ==
                            variables[0]['value']) {
                          memberModel.changeMail(text);
                        }

                        ///パスワード
                        if (inputFormTemplateInRegistrationVariables ==
                            variables[1]['value']) {
                          memberModel.changePassword(text);
                        }

                        ///パスワード確認
                        if (inputFormTemplateInRegistrationVariables ==
                            variables[2]['value']) {
                          memberModel.changePasswordConfirm(text);
                        }

                        ///ニックネーム登録
                        if (inputFormTemplateInRegistrationVariables ==
                            variables[3]['value']) {
                          nicknameModel.changeNickName(text);
                        }
                      },
                      obscureText: obscureText,
                      maxLines: 1,
                      decoration: InputDecoration(
                        errorText: errorTextModel == '' ? null : errorTextModel,
                        labelStyle: TextStyle(
                          color: CustomColors.grayMain,
                        ),
                        filled: true,
                        fillColor: CustomColors.whiteMain,
                        border: InputBorder.none,
                        hintText:isHintText?'catter@example.com':null
                      ),
                    ),
                    SizedBox(
                      height: 2,
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
      ],
    ),
  );
}
