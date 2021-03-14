import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/base/widgets/app_bar.dart';
import 'package:catter_app/presentation/base/widgets/change_current_body.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'base_model.dart';

class BasePage extends StatelessWidget {
  final List<String> _pageNames = [
    'みんなのねこ',
    'ランキング',
    'マイプロフィール',
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<BaseModel>(context, listen: false);
    return Consumer<BaseModel>(
      builder: (context, model, child) {
        final pageIndex = model.currentIndex;
        return Scaffold(
          appBar: changeAppBar(model: model, context: context),
          body: changeCurrentBody(model: model),
          bottomNavigationBar: ConvexAppBar(
            onTap: model.onTapTapped,
            initialActiveIndex: pageIndex,
            color: CustomColors.whiteMain,
            activeColor: CustomColors.brownMain,
            backgroundColor: CustomColors.brownSub,
            items: [
              TabItem(
                icon: Icon(
                  MaterialCommunityIcons.cat,
                  color: CustomColors.whiteMain,
                ),
                title: _pageNames[0],
              ),
              TabItem(
                icon: Icon(
                  MaterialCommunityIcons.crown,
                  color: CustomColors.whiteMain,
                ),
                title: _pageNames[1],
              ),
              TabItem(
                icon: Icon(
                  MaterialCommunityIcons.human,
                  color: CustomColors.whiteMain,
                ),
                title: _pageNames[2],
              ),
            ],
          ),
        );
      },
    );
  }
}
