import 'dart:ui';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_page.dart';
import 'package:catter_app/presentation/cat_posts_comment/cat_posts_comment_page.dart';
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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatsOfAllUsersPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<CatsOfAllUsersModel>(
      create: (_) => CatsOfAllUsersModel()..fetchPostsRealTime(),
      child: Consumer<CatsOfAllUsersModel>(
        builder: (context, model, child) {
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
                                  builder: (context) => CatPostsPage(),
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
                    child: Stack(
                      children: <Widget>[
                        Scrollbar(
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
                                              profilePhotoURL:
                                                  catLists.profilePhotoURL,
                                              displayName: catLists.displayName,
                                              updatedAt: catLists.updatedAt,
                                              isCurrentUser: true,
                                              id: catLists.id,
                                              uid: _auth.currentUser.uid,
                                              userImageTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserPostsPage(
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
                                              profilePhotoURL:
                                                  catLists.profilePhotoURL,
                                              displayName: catLists.displayName,
                                              updatedAt: catLists.updatedAt,
                                              isCurrentUser: false,
                                              id: catLists.id,
                                              userId: catLists.userId,
                                              userImageTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserPostsPage(
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.10,
                                              child: Neumorphic(
                                                style: NeumorphicStyle(
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                    BorderRadius.circular(10),
                                                  ),
                                                  depth: 3,
                                                  color: CustomColors.brownSub,
                                                  border: NeumorphicBorder(
                                                    color:
                                                        CustomColors.brownSub,
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
                                                width: 15,
                                              ),
                                              NeumorphicText(
                                                '名前 : ${catLists.catName}',
                                                textStyle: NeumorphicTextStyle(
                                                    fontSize: 12.5,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                width: 15,
                                              ),
                                              NeumorphicText(
                                                '種類 : ${catLists.catType}',
                                                textStyle: NeumorphicTextStyle(
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                                          Row(
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 18.2610,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 17.890,
                                                          ),
                                                          Icon(
                                                            MaterialCommunityIcons
                                                                .heart_outline,
                                                            size: 29.90,
                                                            color: CustomColors
                                                                .whiteMain,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),

                                                          ///Todo:likeCount
                                                          catLists.likeUserId ==
                                                                  null
                                                              ? Text(
                                                                  '0',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: CustomColors
                                                                        .whiteMain,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  '${catLists.likeUserId.length}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: catLists.likeUserId.contains(model
                                                                            .uid)
                                                                        ? CustomColors
                                                                            .redMain
                                                                        : CustomColors
                                                                            .whiteMain,
                                                                  ),
                                                                ),
                                                          SizedBox(
                                                            width: 25,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              model
                                                                  .startLoading();
                                                              WidgetsBinding
                                                                  .instance
                                                                  .addPostFrameCallback(
                                                                      (_) {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            CatPostsCommentPage(
                                                                      catPhotoURL:
                                                                          catLists
                                                                              .catPhotoURL,
                                                                      displayName:
                                                                          catLists
                                                                              .displayName,
                                                                      profilePhotoURL:
                                                                          catLists
                                                                              .profilePhotoURL,
                                                                      catName:
                                                                          catLists
                                                                              .catName,
                                                                      catType:
                                                                          catLists
                                                                              .catType,
                                                                      postId:
                                                                          catLists
                                                                              .id,
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                              model
                                                                  .endLoading();
                                                            },
                                                            child: Icon(
                                                              MaterialCommunityIcons
                                                                  .comment_processing_outline,
                                                              color: CustomColors
                                                                  .whiteMain,
                                                              size: 29.90,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          catLists.commentCount !=
                                                                  null
                                                              ? Text(
                                                                  '${catLists.commentCount}',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: CustomColors
                                                                        .whiteMain,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  '0',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: CustomColors
                                                                        .whiteMain,
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 66.065,
                                                    height: 66.065,
                                                    child: LottieAnimation(
                                                      model: model,
                                                      isLikePhotos:
                                                          catLists.isLikePhotos,
                                                      id: catLists.id,
                                                      uid:
                                                          _auth.currentUser.uid,
                                                      anotherUid:
                                                          catLists.userId,
                                                      likeUserId: [
                                                        catLists.likeUserId
                                                      ],
                                                    ),
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
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: model.catsOfAllUsersList.isEmpty,
                          child: Center(
                            child: Text(
                              '投稿がありません',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: CustomColors.blackMain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              screenLoading(
                isLoading: model.isLoading,
              ),
            ],
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LottieAnimation extends StatefulWidget {
  LottieAnimation({
    Key key,
    @required this.model,
    @required this.isLikePhotos,
    @required this.id,
    @required this.uid,
    @required this.anotherUid,
    @required this.likeUserId,
  }) : super(key: key);

  CatsOfAllUsersModel model;
  bool isLikePhotos;
  String id;
  String uid;
  String anotherUid;
  List<dynamic> likeUserId;

  @override
  _LottieAnimationState createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Duration duration;
  var isLikePosts = false;

  void _setLikePostsBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  void _getLikePostsBool() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      isLikePosts = prefs.getBool('likePostBool') ?? false;
    });
  }

  @override
  void initState() {
    _getLikePostsBool();
    controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isCompleted) {
          controller.reset();
          widget.isLikePhotos = !widget.isLikePhotos;
        } else {
          controller.forward();
          widget.isLikePhotos = widget.isLikePhotos;
        }
        widget.model.pressedLikeButton(
          isLikePhotos: isLikePosts,
          id: widget.id,
          uid: widget.uid,
          anotherUid: widget.anotherUid,
          likeUserId: widget.likeUserId,
        );
        isLikePosts = !isLikePosts;
        _setLikePostsBool('likePostBool', isLikePosts);
        print(isLikePosts);
      },
      child: Lottie.asset(
        'lib/resources/lottie/836-like-button.json',
        repeat: true,
        controller: controller,
        onLoaded: (composition) {
          controller.duration = composition.duration;
          if (isLikePosts) {
            controller.forward();
          } else {
            controller.reset();
          }
        },
      ),
    );
  }
}
