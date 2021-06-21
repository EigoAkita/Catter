import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/cat_posts_comment/cat_posts_comment_model.dart';
import 'package:catter_app/presentation/cat_posts_comment/widgets/comment_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget commentTile({
  @required CatPostsCommentModel model,
  @required String profilePhotoURL,
  @required String displayName,
  @required String comment,
  @required bool isCurrentUser,
  @required String id,
  @required Function userImageTap,
  String uid,
  String userId,
}) {
  return Stack(
    children: <Widget>[
      Neumorphic(
        style: NeumorphicStyle(
          depth: 2,
          color: CustomColors.whiteMain,
        ),
        child: ListTile(
          trailing: isCurrentUser
              ? commentPopupMenu(
            isCurrentUser: true,
            model: model,
            id: id,
          )
              : commentPopupMenu(
            isCurrentUser: false,
            model: model,
            id: id,
            commentListsUid: userId,
          ),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5,
              ),
              color: profilePhotoURL != null ? null : CustomColors.whiteMain,
            ),
            child: profilePhotoURL != null
                ? GestureDetector(
              onTap: userImageTap,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      profilePhotoURL,
                    ),
                  ),
                ),
              ),
            )
                : GestureDetector(
              onTap: userImageTap,
              child: Icon(
                MaterialCommunityIcons.cat,
                color: CustomColors.brownMain,
              ),
            ),
          ),
          title: displayName != null
              ? Text(
            '$displayName',
            style: TextStyle(
              fontSize: 12.5,
              color: CustomColors.brownSub,
              fontWeight: FontWeight.bold,
            ),
          )
              : Text(
            '名無しさん',
            style: TextStyle(
              fontSize: 12.5,
              color: CustomColors.brownSub,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '$comment',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Visibility(
        visible: isCurrentUser == true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color:
                Colors.pinkAccent,
                borderRadius:
                BorderRadius.circular(
                  2.5,
                ),
              ),
              child: Center(
                child: Text(
                  'YOU',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                    CustomColors.whiteMain,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
