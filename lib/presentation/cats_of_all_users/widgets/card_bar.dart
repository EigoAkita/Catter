import 'package:catter_app/config/convert_weekday_name.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:catter_app/presentation/cats_of_all_users/widgets/popup_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

Widget cardBar({
  @required CatsOfAllUsersModel model,
  @required String profilePhotoURL,
  @required String displayName,
  @required Timestamp updatedAt,
  @required bool isCurrentUser,
  @required String id,
  @required Function userImageTap,
  String uid,
  String userId,
}) {
  return ListTile(
    trailing: isCurrentUser
        ? popupMenu(
            isCurrentUser: true,
            model: model,
            id: id,
            authUid: uid,
          )
        : popupMenu(
            isCurrentUser: false,
            model: model,
            id: id,
            catListsUid: userId,
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
              fontSize: 20,
              color: CustomColors.whiteMain,
              fontWeight: FontWeight.bold,
            ),
          )
        : Text(
            '名無しさん',
            style: TextStyle(
              fontSize: 20,
              color: CustomColors.whiteMain,
              fontWeight: FontWeight.bold,
            ),
          ),
    subtitle: Text(
      '${'${updatedAt.toDate()}'.substring(0, 10)} '
      '${convertWeekdayName(updatedAt.toDate().weekday)}'
      ' ${'${updatedAt.toDate()}'.substring(11, 16)}',
      style: TextStyle(
        fontSize: 10,
        color: CustomColors.whiteMain,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
