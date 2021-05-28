import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_colors.dart';

Widget screenLoading({@required bool isLoading}) {

  return isLoading
      ? Container(
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                CustomColors.brownSub,
              ),
            ),
          ),
        )
      : SizedBox();
}
