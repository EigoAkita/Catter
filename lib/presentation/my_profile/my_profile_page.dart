import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/email_login/email_login_page.dart';
import 'package:catter_app/presentation/my_profile/my_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyProfilePage extends StatelessWidget {
  final nicknameController = TextEditingController();
  final List variables = Variables.inputFormTemplateInRegistrationVariables;
  final double radius = 130;

  List<String> myProfileTextLists = <String>[
    'マイプロフィール',
    '自分の投稿',
    'いいねした投稿',
    'お気に入り',
  ];

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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(height: 65),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 1,
                              color: CustomColors.whiteMain,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(0),
                              ),
                            ),
                            child: Container(
                              color: CustomColors.whiteMain,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.userAlt,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${myProfileTextLists[0]}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.brownMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(height: 65),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 1,
                              color: CustomColors.whiteMain,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(0),
                              ),
                            ),
                            child: Container(
                              color: CustomColors.whiteMain,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(
                                        FontAwesome5.file,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${myProfileTextLists[1]}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.brownMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(height: 65),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 1,
                              color: CustomColors.whiteMain,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(0),
                              ),
                            ),
                            child: Container(
                              color: CustomColors.whiteMain,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(
                                        FontAwesome5.heart,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${myProfileTextLists[2]}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.brownMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(height: 65),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                              depth: 1,
                              color: CustomColors.whiteMain,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(0),
                              ),
                            ),
                            child: Container(
                              color: CustomColors.whiteMain,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Icon(
                                        FontAwesome5.star,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${myProfileTextLists[3]}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.brownMain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: CustomColors.brownMain,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        onPressed: () {
                          model.startLoading();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmailLoginPage(),
                            ),
                          );
                          model.endLoading();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.exit_to_app,
                              color: CustomColors.whiteSub,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ログアウト',
                              style: TextStyle(
                                color: CustomColors.whiteSub,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
