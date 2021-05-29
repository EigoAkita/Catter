import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_colors.dart';

AwesomeDialog mainDialog({
  @required bool isOKOnly,
  @required BuildContext context,
  @required AnimType animType,
  @required DialogType dialogType,
  @required String dialogText,
  @required String subOKText,
  dynamic cancelPress,
  dynamic okPress,
}) {
  return isOKOnly
      ? AwesomeDialog(
          context: context,
          animType: animType,
          dialogType: dialogType,
          body: Center(
            child: Text(
              '$dialogText',
              style: TextStyle(
                color: CustomColors.grayMain,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          btnCancelOnPress: cancelPress,
          btnCancelColor: CustomColors.brownMain,
          btnCancelText: 'いいえ',
          btnOkOnPress: okPress,
          btnOkColor: CustomColors.brownMain,
          btnOkText: '$subOKText',
          buttonsBorderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        )
      : AwesomeDialog(
          context: context,
          animType: animType,
          dialogType: dialogType,
          body: Center(
            child: Text(
              '$dialogText',
              style: TextStyle(
                color: CustomColors.grayMain,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          btnOkOnPress: () {},
          btnOkColor: CustomColors.brownMain,
          btnOkText: '$subOKText',
          buttonsBorderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        )
    ..show();
}
