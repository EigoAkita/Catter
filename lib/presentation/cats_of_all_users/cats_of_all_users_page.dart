import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/main_dialog.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_page.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
                floatingActionButton: NeumorphicFloatingActionButton(
                  style: NeumorphicStyle(
                    depth: 1,
                    color: CustomColors.brownSub,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(170),
                    ),
                  ),
                  child: Icon(
                    MaterialCommunityIcons.plus,
                    size: 40,
                    color: CustomColors.whiteMain,
                  ),
                  onPressed: () {
                    model.startLoading();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatPostsPage(),
                      ),
                    );
                    model.endLoading();
                  },
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Visibility(
                                    visible: catLists.userId ==
                                        _auth.currentUser.uid,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            NeumorphicButton(
                                              child: Center(
                                                child: Text(
                                                  '削除',
                                                  style: TextStyle(
                                                    color:
                                                        CustomColors.whiteMain,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              style: NeumorphicStyle(
                                                depth: 2,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(5),
                                                ),
                                                color: CustomColors.grayMain,
                                                border: NeumorphicBorder(
                                                  color: CustomColors.whiteMain,
                                                  width: 3,
                                                ),
                                              ),
                                              onPressed: () async {
                                                mainDialog(
                                                  isOKOnly: true,
                                                  context: context,
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  dialogType:
                                                      DialogType.QUESTION,
                                                  dialogText: '投稿を削除しますか？',
                                                  subOKText: 'はい',
                                                  cancelPress: () {},
                                                  okPress: () async {
                                                    await model.deleteMyPost(
                                                      id: catLists.id,
                                                      uid:
                                                          _auth.currentUser.uid,
                                                    );
                                                    await model.fetchPosts();
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: catLists.userId !=
                                        _auth.currentUser.uid,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            NeumorphicButton(
                                              child: Center(
                                                child: const Text(
                                                  '通報',
                                                  style: TextStyle(
                                                    color:
                                                        CustomColors.whiteMain,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              style: NeumorphicStyle(
                                                depth: 2,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(5),
                                                ),
                                                color: Colors.orange,
                                                border: NeumorphicBorder(
                                                  color: CustomColors.whiteMain,
                                                  width: 3,
                                                ),
                                              ),
                                              onPressed: () async {
                                                mainDialog(
                                                  isOKOnly: true,
                                                  context: context,
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  dialogType:
                                                      DialogType.WARNING,
                                                  dialogText:
                                                      '不適切な内容や画像として\n報告（通報）しますか？',
                                                  cancelPress: () {},
                                                  subOKText: 'はい',
                                                  okPress: () async {
                                                    model.startLoading();
                                                    await model.fetchContact();
                                                    try {
                                                      await model.submitForm(
                                                        inappropriatePost:
                                                            catLists.id,
                                                        anotherContributor:
                                                            catLists.userId,
                                                      );
                                                      mainDialog(
                                                          isOKOnly: false,
                                                          context: context,
                                                          animType: AnimType
                                                              .BOTTOMSLIDE,
                                                          dialogType: DialogType
                                                              .NO_HEADER,
                                                          dialogText:
                                                              '報告（通報）が完了しました',
                                                          subOKText: 'はい');
                                                      model.endLoading();
                                                    } catch (e) {
                                                      model.endLoading();
                                                      errorShowDialog(
                                                          loginErrorText:
                                                              'エラーが発生しました',
                                                          context: context);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            NeumorphicButton(
                                              child: Center(
                                                child: const Text(
                                                  'ブロック',
                                                  style: TextStyle(
                                                    color:
                                                        CustomColors.whiteMain,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              style: NeumorphicStyle(
                                                depth: 2,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(5),
                                                ),
                                                color: Colors.red,
                                                border: NeumorphicBorder(
                                                  color: CustomColors.whiteMain,
                                                  width: 3,
                                                ),
                                              ),
                                              onPressed: () async {
                                                mainDialog(
                                                  isOKOnly: true,
                                                  context: context,
                                                  animType:
                                                      AnimType.BOTTOMSLIDE,
                                                  dialogType:
                                                      DialogType.WARNING,
                                                  dialogText: 'この投稿をブロックしますか？',
                                                  subOKText: 'ブロックする',
                                                  cancelPress: () {},
                                                  okPress: () async {
                                                    model.startLoading();
                                                    try {
                                                      await model
                                                          .blockUserPosts(
                                                        id: catLists.id,
                                                      );
                                                      mainDialog(
                                                          isOKOnly: false,
                                                          context: context,
                                                          animType: AnimType
                                                              .BOTTOMSLIDE,
                                                          dialogType: DialogType
                                                              .NO_HEADER,
                                                          dialogText:
                                                              '投稿をブロックしました',
                                                          subOKText: 'はい');
                                                      model.endLoading();
                                                    } catch (e) {
                                                      model.endLoading();
                                                      errorShowDialog(
                                                          loginErrorText:
                                                              'エラーが発生しました',
                                                          context: context);
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
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
                                      Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide /
                                                1.26,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Text(
                                                    '名前 : ${catLists.catName}',
                                                    style: TextStyle(
                                                      fontSize: 12.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CustomColors
                                                          .whiteMain,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Text(
                                                    '種類 : ${catLists.catType}',
                                                    style: TextStyle(
                                                      fontSize: 12.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: CustomColors
                                                          .whiteMain,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
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
