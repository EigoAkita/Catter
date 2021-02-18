import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_page.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.15,
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(10),
                                        ),
                                        depth: 2,
                                        color: CustomColors.brownSub,
                                        border: NeumorphicBorder(
                                          color: CustomColors.brownSub,
                                          width: 5,
                                        ),
                                      ),
                                      child: Image(
                                        image:
                                            NetworkImage(catLists.catPhotoURL),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        '名前 : ${catLists.catName}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.whiteMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  catLists.catType.length > 14
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Text(
                                              '種類 : ${catLists.catType}',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: CustomColors.whiteMain,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Text(
                                              '種類 : ${catLists.catType}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: CustomColors.whiteMain,
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Visibility(
                                    visible:
                                        catLists.uid == _auth.currentUser.uid,
                                    child: SizedBox(
                                      width: 145,
                                      height: 55,
                                      child: NeumorphicButton(
                                        style: NeumorphicStyle(
                                          depth: 1,
                                          color: CustomColors.grayMain,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async {
                                          model.startLoading();
                                          await model.deleteMyPost(
                                            id: catLists.id,
                                            uid: _auth.currentUser.uid,
                                          );
                                          await model.fetchPosts();
                                          model.endLoading();
                                        },
                                        child: Center(
                                          child: Text(
                                            '投稿を削除する',
                                            style: TextStyle(
                                              color: CustomColors.whiteMain,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        catLists.uid != _auth.currentUser.uid,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 20,
                                            ),
                                            NeumorphicFloatingActionButton(
                                              style: NeumorphicStyle(
                                                depth: 1,
                                                color: model.isFavoritePhotos
                                                    ? CustomColors.whiteMain
                                                    : Colors.amberAccent,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(170),
                                                ),
                                              ),
                                              child: Icon(
                                                FontAwesome5.star,
                                                size: 25,
                                                color: model.isFavoritePhotos
                                                    ? CustomColors.grayMain
                                                    : CustomColors.whiteMain,
                                              ),
                                              onPressed: () {
                                                model.pressedFavoriteButton(
                                                  id: catLists.id,
                                                  uid: _auth.currentUser.uid,
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            NeumorphicFloatingActionButton(
                                              style: NeumorphicStyle(
                                                depth: 1,
                                                color: model.isLikePhotos
                                                    ? CustomColors.whiteMain
                                                    : Colors.pinkAccent,
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(170),
                                                ),
                                              ),
                                              child: Icon(
                                                FontAwesome5.heart,
                                                size: 25,
                                                color: model.isLikePhotos
                                                    ? CustomColors.grayMain
                                                    : CustomColors.whiteMain,
                                              ),
                                              onPressed: () {
                                                model.pressedLikeButton(
                                                    id: catLists.id,
                                                    uid: catLists.uid);
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            SizedBox(
                                              width: 100,
                                              height: 55,
                                              child: NeumorphicButton(
                                                style: NeumorphicStyle(
                                                  depth: 1,
                                                  color: Colors.red,
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                    BorderRadius.circular(10),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Center(
                                                  child: Text(
                                                    '通報する',
                                                    style: TextStyle(
                                                      color: CustomColors
                                                          .whiteMain,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
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
