import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_page.dart';
import 'package:catter_app/presentation/my_profile/my_profile_page.dart';
import 'package:catter_app/presentation/ranking/ranking_page.dart';
import 'package:flutter/material.dart';
import '../base_model.dart';

Widget changeCurrentBody({
  @required BaseModel model,
}) {
  return SafeArea(
    child: Stack(
      children: <Widget>[
        Offstage(
          offstage: model.currentIndex != 0,
          child: CatsOfAllUsersPage(),
        ),
        Offstage(
          offstage: model.currentIndex != 1,
          child: RankingPage(),
        ),
        Offstage(
          offstage: model.currentIndex != 2,
          child: MyProfilePage(),
        ),
      ],
    ),
  );
}
