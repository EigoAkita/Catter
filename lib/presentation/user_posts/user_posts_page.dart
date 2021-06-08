import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/user_posts/user_posts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserPostsPage extends StatelessWidget {
  UserPostsPage({@required this.userId});

  String userId;
  final double radius = 130;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<UserPostsModel>(
      create: (_) => UserPostsModel(userId: userId)
        ..fetchUserPostsRealTime()
        ..init(),
      child: Consumer<UserPostsModel>(builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: CustomColors.brownSub,
                  brightness: Brightness.dark,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BasePage(),
                        ),
                      );
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 20) {
                        Navigator.of(context).pop();
                      }
                    },
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
                                  height: 285,
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
                                    '${model.postedCount} posts',
                                    textStyle: NeumorphicTextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    style: NeumorphicStyle(
                                      depth: 1,
                                      color: CustomColors.whiteMain,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SingleChildScrollView(
                                    child: SizedBox(
                                      height: data.size.height,
                                      width: data.size.width,
                                      child: GridView.extent(
                                        maxCrossAxisExtent: data.size.width / 3,
                                        padding: const EdgeInsets.all(6),
                                        mainAxisSpacing: 6,
                                        crossAxisSpacing: 6,
                                        children: model.catsOfAllUsersList
                                            .map(
                                              (userPosts) => Neumorphic(
                                                style: NeumorphicStyle(
                                                  depth: 1,
                                                  color: CustomColors.brownSub,
                                                  border: NeumorphicBorder(
                                                    width: 2,
                                                    color: CustomColors.brownSub,
                                                  ),
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                    BorderRadius.circular(0),
                                                  ),
                                                ),
                                                child: Image(
                                                  image: NetworkImage(
                                                      '${userPosts.catPhotoURL}'),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
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
