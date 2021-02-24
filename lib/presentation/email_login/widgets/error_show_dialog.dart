import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> errorShowDialog({
  @required String loginErrorText,
  @required BuildContext context,
}) async {
  return AwesomeDialog(
    context: context,
    animType: AnimType.BOTTOMSLIDE,
    dialogType: DialogType.ERROR,
    body: Center(
      child: Text(
        '$loginErrorText',
        style: TextStyle(
          color: CustomColors.grayMain,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
    btnOkOnPress: () {

    },
    btnOkColor: CustomColors.brownMain,
    btnOkText: 'はい',
    buttonsBorderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  )..show();
}
