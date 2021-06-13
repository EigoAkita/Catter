import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/my_favorite_post_screen/my_favorite_post_screen_page.dart';
import 'package:catter_app/presentation/my_liked_post_screen/my_liked_post_screen_page.dart';
import 'package:catter_app/presentation/my_post_screen/my_post_screen_page.dart';
import 'package:catter_app/presentation/my_profile/my_profile_model.dart';
import 'package:catter_app/presentation/my_profile/widgets/transition_button.dart';
import 'package:catter_app/presentation/my_profile_change/my_profile_change_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyProfilePage extends StatelessWidget {
  final double radius = 130;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<MyProfileModel>(
      create: (_) => MyProfileModel()..init(),
      child: Consumer<MyProfileModel>(builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(0),
                                ),
                                depth: 1,
                                color: CustomColors.brownSub,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 280,
                                color: CustomColors.brownSub,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                model.profilePhotoURL != null
                                    ? Stack(
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: radius,
                                              height: radius,
                                              child: Neumorphic(
                                                style: NeumorphicStyle(
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                    BorderRadius.circular(170),
                                                  ),
                                                  depth: 1,
                                                  color: CustomColors.brownSub,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: radius,
                                              height: radius,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: CustomColors.brownSub,
                                                  width: 5,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  model.profilePhotoURL,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        children: <Widget>[
                                          Center(
                                            child: Neumorphic(
                                              style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(170),
                                                ),
                                                depth: 1,
                                                color: CustomColors.brownSub,
                                              ),
                                              child: Container(
                                                width: radius,
                                                height: radius,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color:
                                                        CustomColors.brownSub,
                                                    width: 5,
                                                  ),
                                                  color: CustomColors.whiteMain,
                                                ),
                                                child: Container(
                                                  width: radius,
                                                  height: radius,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Center(
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  size: 30,
                                                  color: CustomColors.grayMain,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                NeumorphicText(
                                  '${model.displayName}',
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: CustomColors.whiteMain,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                NeumorphicText(
                                  ' ${model.likedCount} likes｜${model.postedCount} posts',
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  style: NeumorphicStyle(
                                    depth: 1,
                                    color: CustomColors.whiteMain,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfileChangePage(
                              ),
                            ),
                          );
                        },
                        transitionIcon: Icon(
                          MaterialCommunityIcons.human,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: 'マイプロフィール',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyPostScreenPage(
                              ),
                            ),
                          );
                        },
                        transitionIcon: Icon(
                          MaterialCommunityIcons.file_document_box,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: '自分の投稿',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyLikedPostScreenPage(
                              ),
                            ),
                          );
                        },
                        transitionIcon: Icon(
                          MaterialCommunityIcons.heart,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: 'いいね',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyFavoritePostScreenPage(
                              ),
                            ),
                          );
                        },
                        transitionIcon: Icon(
                          MaterialCommunityIcons.star,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: 'お気に入り',
                      ),
                      SizedBox(
                        height: 10,
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
      }),
    );
  }
}
