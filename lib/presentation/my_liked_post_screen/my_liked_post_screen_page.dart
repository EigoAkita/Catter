import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'my_liked_post_screen_model.dart';

class MyLikedPostScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<MyLikedPostScreenModel>(
      create: (_) => MyLikedPostScreenModel()..fetchMyLikedPostRealTime(),
      child: Consumer<MyLikedPostScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'いいねした投稿',
                style: TextStyle(
                  color: CustomColors.whiteMain,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 3,
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
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: SizedBox(
                    height: data.size.height,
                    width: data.size.width,
                    child: GridView.extent(
                      maxCrossAxisExtent: data.size.width / 3,
                      padding: const EdgeInsets.all(6),
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      children: model.myLikedPostScreenList
                          .map(
                            (myLikedPosts) => Neumorphic(
                          style: NeumorphicStyle(
                            depth: 1,
                            color: CustomColors.brownSub,
                            border: NeumorphicBorder(
                              width: 2,
                              color: CustomColors.brownSub,
                            ),
                            boxShape:
                            NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(0),
                            ),
                          ),
                          child: Image(
                            image: NetworkImage('${myLikedPosts.catPhotoURL}'),
                          ),
                        ),
                      )
                          .toList(),
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
            ),
          );
        },
      ),
    );
  }
}
