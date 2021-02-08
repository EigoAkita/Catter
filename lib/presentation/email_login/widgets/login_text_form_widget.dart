import 'package:catter_app/config/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget loginTextFormWidget({
  @required emailLoginModel,
  @required dynamic isController,
  @required bool isChange,
  @required bool isErrorText,
  @required String labelText,
}) {
  return Row(
    children: <Widget>[
      const Expanded(
        flex: 1,
        child: SizedBox(),
      ),
      Expanded(
        flex: 8,
        child: Neumorphic(
          style: const NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: 1,
            color: CustomColors.whiteMain,
            shadowDarkColorEmboss: Colors.blueGrey,
          ),
          child: TextFormField(
            controller: isController,
            onChanged: (text) {
              isChange
                  ? emailLoginModel.changeMail(text)
                  : emailLoginModel.changePassword(text);
            },
            // obscureText: true,
            maxLines: 1,
            decoration: InputDecoration(
              errorText: isErrorText
                  ? emailLoginModel.errorMail == ''
                      ? null
                      : emailLoginModel.errorMail
                  : emailLoginModel.errorPassword == ''
                      ? null
                      : emailLoginModel.errorPassword,
              labelText: labelText,
              labelStyle: TextStyle(color: CustomColors.grayMain),
              filled: true,
              fillColor: CustomColors.whiteMain,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      const Expanded(
        flex: 1,
        child: SizedBox(),
      ),
    ],
  );
}
