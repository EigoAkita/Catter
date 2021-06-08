import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/my_favorite_post_screen/my_favorite_post_screen_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class MyFavoritePostScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<MyFavoritePostScreenModel>(
      create: (_) => MyFavoritePostScreenModel()..fetchMyFavoritePostRealTime(),
      child: Consumer<MyFavoritePostScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'お気に入り',
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
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 20) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: SizedBox(
                      height: data.size.height,
                      width: data.size.width,
                      child: GridView.extent(
                        maxCrossAxisExtent: data.size.width / 3,
                        padding: const EdgeInsets.all(6),
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        children: model.myFavoritePostScreenList
                            .map(
                              (myFavoritePosts) => Neumorphic(
                                style: NeumorphicStyle(
                                  depth: 1,
                                  color: CustomColors.brownSub,
                                  border: NeumorphicBorder(
                                    width: 2,
                                    color: CustomColors.brownSub,
                                  ),
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(0),
                                  ),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                      '${myFavoritePosts.catPhotoURL}'),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                screenLoading(
                  isLoading: model.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
