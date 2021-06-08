import 'dart:ui';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_page.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:catter_app/presentation/cats_of_all_users/widgets/card_bar.dart';
import 'package:catter_app/presentation/user_posts/user_posts_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class CatsOfAllUsersPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<CatsOfAllUsersModel>(
      create: (_) => CatsOfAllUsersModel()..fetchPostsRealTime(),
      child: Consumer<CatsOfAllUsersModel>(builder: (context, model, child) {
        final catLists = model.catsOfAllUsersList;
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                floatingActionButton: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Neumorphic(
                      style: NeumorphicStyle(
                        depth: 1,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(30),
                        ),
                      ),
                      child: LiteRollingSwitch(
                          value: model.isCurrentUserPost,
                          textOn: 'じぶん',
                          textOff: 'みんな',
                          colorOn: CustomColors.brownSub,
                          colorOff: CustomColors.brownMain,
                          iconOn: MaterialCommunityIcons.human_male,
                          iconOff: MaterialCommunityIcons.human_male_male,
                          animationDuration: Duration(milliseconds: 600),
                          onChanged: (value) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              model.changeCurrentUserPosts();
                            });
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: NeumorphicFloatingActionButton(
                        style: NeumorphicStyle(
                          depth: 1,
                          color: CustomColors.brownSub,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(25),
                          ),
                        ),
                        child: Icon(
                          MaterialCommunityIcons.plus,
                          size: 35,
                          color: CustomColors.whiteMain,
                        ),
                        onPressed: () {
                          model.startLoading();
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CatPostsPage(
                                ),
                              ),
                            );
                          });
                          model.endLoading();
                        },
                      ),
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: catLists
                          .map(
                            (catLists) => Card(
                              shadowColor: CustomColors.grayMain,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: CustomColors.brownSub,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: catLists.userId ==
                                        _auth.currentUser.uid,
                                    child: cardBar(
                                      model: model,
                                      profilePhotoURL: catLists.profilePhotoURL,
                                      displayName: catLists.displayName,
                                      updatedAt: catLists.updatedAt,
                                      isCurrentUser: true,
                                      id: catLists.id,
                                      uid: _auth.currentUser.uid,
                                      userImageTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserPostsPage(
                                              userId: catLists.userId,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Visibility(
                                    visible: catLists.userId !=
                                        _auth.currentUser.uid,
                                    child: cardBar(
                                      model: model,
                                      profilePhotoURL: catLists.profilePhotoURL,
                                      displayName: catLists.displayName,
                                      updatedAt: catLists.updatedAt,
                                      isCurrentUser: false,
                                      id: catLists.id,
                                      userId: catLists.userId,
                                      userImageTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserPostsPage(
                                              userId: catLists.userId,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.10,
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(10),
                                          ),
                                          depth: 3,
                                          color: CustomColors.brownSub,
                                          border: NeumorphicBorder(
                                            color: CustomColors.brownSub,
                                            width: 5,
                                          ),
                                        ),
                                        child: Image(
                                          image: NetworkImage(
                                            catLists.catPhotoURL,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                      ),
                                      NeumorphicText(
                                        '名前 : ${catLists.catName}',
                                        textStyle: NeumorphicTextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold),
                                        style: NeumorphicStyle(
                                          depth: 1,
                                          color: CustomColors.whiteMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                      ),
                                      NeumorphicText(
                                        '種類 : ${catLists.catType}',
                                        textStyle: NeumorphicTextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold),
                                        style: NeumorphicStyle(
                                          depth: 1,
                                          color: CustomColors.whiteMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Visibility(
                                    visible: catLists.userId !=
                                        _auth.currentUser.uid,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 10,
                                            ),
                                            NeumorphicFloatingActionButton(
                                              style: NeumorphicStyle(
                                                depth: 1,
                                                color: catLists.isFavoritePhotos
                                                    ? CustomColors.whiteMain
                                                    : Colors.amberAccent,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Icon(
                                                MaterialCommunityIcons.star,
                                                size: 30,
                                                color: catLists.isFavoritePhotos
                                                    ? CustomColors.grayMain
                                                    : CustomColors.whiteMain,
                                              ),
                                              onPressed: () async {
                                                catLists.isFavoritePhotos =
                                                    !catLists.isFavoritePhotos;
                                                await model
                                                    .pressedFavoriteButton(
                                                  isFavoritePhotos:
                                                      catLists.isFavoritePhotos,
                                                  id: catLists.id,
                                                  uid: _auth.currentUser.uid,
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            NeumorphicText(
                                              'or',
                                              style: NeumorphicStyle(
                                                depth: 1,
                                                color: CustomColors.whiteMain,
                                              ),
                                              textStyle: NeumorphicTextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            NeumorphicFloatingActionButton(
                                              style: NeumorphicStyle(
                                                depth: 1,
                                                color: catLists.isLikePhotos
                                                    ? CustomColors.whiteMain
                                                    : Colors.pinkAccent,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Icon(
                                                MaterialCommunityIcons.heart,
                                                size: 30,
                                                color: catLists.isLikePhotos
                                                    ? CustomColors.grayMain
                                                    : CustomColors.whiteMain,
                                              ),
                                              onPressed: () {
                                                catLists.isLikePhotos =
                                                    !catLists.isLikePhotos;
                                                model.pressedLikeButton(
                                                  isLikePhotos:
                                                      catLists.isLikePhotos,
                                                  id: catLists.id,
                                                  uid: _auth.currentUser.uid,
                                                  anotherUid: catLists.userId,
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
            screenLoading(
              isLoading: model.isLoading,
            ),
          ],
        );
      }),
    );
  }
}
