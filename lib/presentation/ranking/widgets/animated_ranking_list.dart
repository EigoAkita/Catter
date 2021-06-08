import 'package:auto_animated/auto_animated.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/ranking/ranking_model.dart';
import 'package:catter_app/presentation/user_posts/user_posts_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// ignore: must_be_immutable
class AnimatedRankingList extends StatelessWidget {
  AnimatedRankingList({@required this.rankingModel});

  RankingModel rankingModel;

  @override
  Widget build(BuildContext context) {
    final _rankingModel = rankingModel;
    final _ranking = _rankingModel.rankingList;
    final data = MediaQuery.of(context);
    final _rankingList = _ranking.length;

    Widget _buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: SingleChildScrollView(
              child: SizedBox(
                height: data.size.height,
                width: data.size.width,
                child: ListView(
                  children: _ranking
                      .map(
                        (rankingLists) => Card(
                          elevation: 2,
                          shadowColor: CustomColors.grayMain,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: CustomColors.brownSub,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 60,
                                        height: 60,
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(10),
                                            ),
                                            depth: 2,
                                            color: CustomColors.brownSub,
                                            border: NeumorphicBorder(
                                              color: CustomColors.brownSub,
                                              width: 5,
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserPostsPage(
                                                    userId: rankingLists.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image(
                                              image: NetworkImage(
                                                rankingLists.profilePhotoURL,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      NeumorphicText(
                                        '${rankingLists.displayName}',
                                        textStyle: NeumorphicTextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        style: NeumorphicStyle(
                                          color: CustomColors.whiteMain,
                                          depth: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.vertical(
                                                  top: Radius.circular(10)),
                                            ),
                                            depth: 1,
                                            color: CustomColors.brownSub,
                                          ),
                                          child: Center(
                                            child:
                                                _ranking.indexOf(rankingLists) +
                                                            1 >
                                                        1000
                                                    ? NeumorphicText(
                                                        '${_ranking.indexOf(rankingLists) + 1}',
                                                        textStyle:
                                                            NeumorphicTextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        style: NeumorphicStyle(
                                                          color: CustomColors
                                                              .whiteMain,
                                                          depth: 1,
                                                        ),
                                                      )
                                                    : NeumorphicText(
                                                        '${_ranking.indexOf(rankingLists) + 1}',
                                                        textStyle:
                                                            NeumorphicTextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        style: NeumorphicStyle(
                                                          color: CustomColors
                                                              .whiteMain,
                                                          depth: 1,
                                                        ),
                                                      ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 90,
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.vertical(
                                                  bottom: Radius.circular(10)),
                                            ),
                                            depth: 1,
                                            color: CustomColors.brownMain,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              rankingLists.likedCount > 1000
                                                  ? NeumorphicIcon(
                                                      MaterialCommunityIcons
                                                          .heart,
                                                      size: 15,
                                                      style: NeumorphicStyle(
                                                        depth: 1,
                                                        color: CustomColors
                                                            .brownSub,
                                                      ),
                                                    )
                                                  : NeumorphicIcon(
                                                      MaterialCommunityIcons
                                                          .heart,
                                                      size: 20,
                                                      style: NeumorphicStyle(
                                                        depth: 1,
                                                        color: CustomColors
                                                            .brownSub,
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              rankingLists.likedCount > 1000
                                                  ? NeumorphicText(
                                                      '${rankingLists.likedCount}',
                                                      textStyle:
                                                          NeumorphicTextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      style: NeumorphicStyle(
                                                        color: CustomColors
                                                            .brownSub,
                                                        depth: 1,
                                                      ),
                                                    )
                                                  : NeumorphicText(
                                                      '${rankingLists.likedCount}',
                                                      textStyle:
                                                          NeumorphicTextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      style: NeumorphicStyle(
                                                        color: CustomColors
                                                            .brownSub,
                                                        depth: 1,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
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
        );

    return LiveList(
      padding: EdgeInsets.all(5),
      delay: Duration(seconds: 1),
      showItemInterval: Duration(milliseconds: 375),
      showItemDuration: Duration(seconds: 1),
      scrollDirection: Axis.vertical,
      itemCount: _rankingList,
      itemBuilder: (context, index, animation) {
        return _buildAnimatedItem(
          context,
          index,
          animation,
        );
      },
    );
  }
}
