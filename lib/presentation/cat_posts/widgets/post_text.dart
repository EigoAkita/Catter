import 'package:catter_app/config/custom_colors.dart';
import 'package:flutter/cupertino.dart';

Widget postText({@required String postName}) {
  return Text(
    '$postName',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: CustomColors.whiteMain,
    ),
  );
}
