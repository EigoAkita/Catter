import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../base_model.dart';

/// AppBarの表示切り替え
// ignore: missing_return
AppBar changeAppBar({
  @required BaseModel model,
  @required BuildContext context,
}) {
  switch (model.currentIndex) {
    case 0:
      return AppBar(
        title: Text(
          'みんなのねこ',
          style: TextStyle(
            color: CustomColors.whiteMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        backgroundColor: CustomColors.brownSub,
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
      );
      break;
    case 1:
      return AppBar(
        title: Text(
          'ランキング',
          style: TextStyle(
            color: CustomColors.whiteMain,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3,
        backgroundColor: CustomColors.brownSub,
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
      );
      break;
    case 2:
      return AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                         SettingPage(),
                    ),
                  );
                },
                child: NeumorphicIcon(
                  MaterialCommunityIcons.settings,
                  size: 50,
                  style: NeumorphicStyle(
                    depth: 1,
                    color: CustomColors.whiteMain,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
        elevation: 0,
        backgroundColor: CustomColors.brownSub,
        automaticallyImplyLeading: false,
      );
      break;
    default:
      break;
  }
}
