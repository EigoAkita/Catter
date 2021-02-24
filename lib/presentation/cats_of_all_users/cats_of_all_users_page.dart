import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_page.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatsOfAllUsersPage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<CatsOfAllUsersModel>(
      create: (_) => CatsOfAllUsersModel()
        ..fetchPostsRealTime(),
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
                    FontAwesome.plus,
                    size: 30,
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
                                  SizedBox(
                                    height: 15,
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
                                      Visibility(
                                        visible: catLists.uid ==
                                            _auth.currentUser.uid,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                AntDesign.delete,
                                                color: CustomColors.grayMain,
                                                size: 25,
                                              ),
                                              onPressed: () async {
                                                AwesomeDialog(
                                                  context: context,
                                                  animType: AnimType.BOTTOMSLIDE,
                                                  dialogType: DialogType.QUESTION,
                                                  body: Center(
                                                    child: Text(
                                                      '投稿を削除しますか？',
                                                      style: TextStyle(
                                                        color: CustomColors.grayMain,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  btnCancelOnPress: (){

                                                  },
                                                  btnCancelColor: CustomColors.brownMain,
                                                  btnCancelText: 'いいえ',
                                                  btnOkOnPress: ()async{
                                                    await model.deleteMyPost(
                                                      id: catLists.id,
                                                      uid: _auth.currentUser.uid,
                                                    );
                                                    await model.fetchPosts();
                                                  },
                                                  btnOkColor: CustomColors.brownMain,
                                                  btnOkText: 'はい',
                                                  buttonsBorderRadius: BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                )..show();
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: catLists.uid !=
                                            _auth.currentUser.uid,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(
                                                AntDesign.exclamationcircle,
                                                color: Colors.red,
                                                size: 25,
                                              ),
                                              onPressed: () {
                                                AwesomeDialog(
                                                  context: context,
                                                  animType: AnimType.BOTTOMSLIDE,
                                                  dialogType: DialogType.WARNING,
                                                  body: Center(
                                                    child: Text(
                                                      'この投稿を不適切な内容として\n報告（通報）しますか？',
                                                      style: TextStyle(
                                                        color: CustomColors.grayMain,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  btnCancelOnPress: (){

                                                  },
                                                  btnCancelColor: CustomColors.brownMain,
                                                  btnCancelText: 'いいえ',
                                                  btnOkOnPress: () {
                                                    AwesomeDialog(
                                                      context: context,
                                                      animType: AnimType.BOTTOMSLIDE,
                                                      dialogType: DialogType.NO_HEADER,
                                                      body: Center(
                                                        child: Text(
                                                          '報告（通報）が完了しました',
                                                          style: TextStyle(
                                                            color: CustomColors.grayMain,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      btnOkOnPress: (){
                                                      },
                                                      btnOkColor: CustomColors.brownMain,
                                                      btnOkText: 'はい',
                                                      buttonsBorderRadius: BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                    )..show();
                                                  },
                                                  btnOkColor: CustomColors.brownMain,
                                                  btnOkText: 'はい',
                                                  buttonsBorderRadius: BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                )..show();
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
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
                                    visible:
                                        catLists.uid != _auth.currentUser.uid,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                NeumorphicFloatingActionButton(
                                                  style: NeumorphicStyle(
                                                    depth: 1,
                                                    color:catLists.isFavoritePhotos
                                                        ? CustomColors.whiteMain
                                                        : Colors.amberAccent,
                                                    boxShape: NeumorphicBoxShape
                                                        .roundRect(
                                                      BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    FontAwesome5.star,
                                                    size: 25,
                                                    color:catLists.isFavoritePhotos
                                                        ? CustomColors.grayMain
                                                        : CustomColors
                                                            .whiteMain,
                                                  ),
                                                  onPressed: () async {
                                                    catLists.isFavoritePhotos =
                                                        !catLists
                                                            .isFavoritePhotos;
                                                    await model
                                                        .pressedFavoriteButton(
                                                      isFavoritePhotos: catLists
                                                          .isFavoritePhotos,
                                                      id: catLists.id,
                                                      uid:
                                                          _auth.currentUser.uid,
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 50,
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
                                                    FontAwesome5.heart,
                                                    size: 25,
                                                    color: catLists.isLikePhotos
                                                        ? CustomColors.grayMain
                                                        : CustomColors
                                                            .whiteMain,
                                                  ),
                                                  onPressed: () {
                                                    catLists.isLikePhotos =
                                                        !catLists.isLikePhotos;
                                                    model.pressedLikeButton(
                                                      isLikePhotos:
                                                          catLists.isLikePhotos,
                                                      id: catLists.id,
                                                      uid:
                                                          _auth.currentUser.uid,
                                                      anotherUid: catLists.uid,
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
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
            model.isLoading
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
                : SizedBox(),
          ],
        );
      }),
    );
  }
}
