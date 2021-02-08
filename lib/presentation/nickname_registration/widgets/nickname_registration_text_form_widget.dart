import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/nickname_registration/nickname_registration_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final List variables = Variables.inputFormTemplateInRegistrationVariables;

Widget nickNameRegistrationTextFormWidget({
  NicknameRegistrationModel nicknameModel,
  @required errorTextModel,
  @required dynamic isController,
  @required Object inputFormTemplateInRegistrationVariables,
  @required BuildContext context,
}) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width / 1.15,
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
              flex: 11,
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
                      textAlign: TextAlign.center,
                      controller: isController,
                      onChanged: (text) {
                        ///ニックネーム登録
                        nicknameModel.changeNickName(text);
                      },
                      obscureText: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                        errorText:
                            errorTextModel == '' ? null : errorTextModel,
                        filled: true,
                        fillColor: CustomColors.whiteMain,
                        border: InputBorder.none,
                        hintText: 'ラテ丸',
                        hintStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
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
