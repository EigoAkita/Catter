import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/main_dialog.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget popupMenu({
  @required bool isCurrentUser,
  @required CatsOfAllUsersModel model,
  @required String id,
  String authUid,
  String catListsUid,
}) =>
    isCurrentUser
        ? PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    mainDialog(
                      isOKOnly: true,
                      context: context,
                      animType: AnimType.BOTTOMSLIDE,
                      dialogType: DialogType.QUESTION,
                      dialogText: '投稿を削除しますか？',
                      subOKText: 'はい',
                      cancelPress: () {},
                      okPress: () async {
                        await model.deleteMyPost(
                          id: id,
                          uid: authUid,
                        );
                        await model.fetchPosts();
                      },
                    );
                  },
                  child: Text(
                    "削除",
                    style: TextStyle(
                        color: CustomColors.whiteMain,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: CustomColors.brownSub,
            icon: Icon(
              Icons.more_horiz,
              size: 35,
              color: CustomColors.whiteMain,
            ),
          )
        : PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    mainDialog(
                      isOKOnly: true,
                      context: context,
                      animType: AnimType.BOTTOMSLIDE,
                      dialogType: DialogType.WARNING,
                      dialogText: '不適切な内容や画像として\n報告（通報）しますか？',
                      cancelPress: () {},
                      subOKText: 'はい',
                      okPress: () async {
                        model.startLoading();
                        await model.fetchContact();
                        try {
                          await model.submitForm(
                            inappropriatePost: id,
                            anotherContributor: catListsUid,
                          );
                          mainDialog(
                              isOKOnly: false,
                              context: context,
                              animType: AnimType.BOTTOMSLIDE,
                              dialogType: DialogType.NO_HEADER,
                              dialogText: '報告（通報）が完了しました',
                              subOKText: 'はい');
                          model.endLoading();
                        } catch (e) {
                          model.endLoading();
                          errorShowDialog(
                              loginErrorText: 'エラーが発生しました', context: context);
                        }
                      },
                    );
                  },
                  child: Text(
                    "通報",
                    style: TextStyle(
                        color: CustomColors.whiteMain,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: GestureDetector(
                  onTap: () {
                    mainDialog(
                      isOKOnly: true,
                      context: context,
                      animType:
                      AnimType.BOTTOMSLIDE,
                      dialogType:
                      DialogType.WARNING,
                      dialogText: 'この投稿をブロックしますか？',
                      subOKText: 'ブロックする',
                      cancelPress: () {},
                      okPress: () async {
                        model.startLoading();
                        try {
                          await model
                              .blockUserPosts(
                            id: id,
                          );
                          mainDialog(
                              isOKOnly: false,
                              context: context,
                              animType: AnimType
                                  .BOTTOMSLIDE,
                              dialogType: DialogType
                                  .NO_HEADER,
                              dialogText:
                              '投稿をブロックしました',
                              subOKText: 'はい');
                          model.endLoading();
                        } catch (e) {
                          model.endLoading();
                          errorShowDialog(
                              loginErrorText:
                              'エラーが発生しました',
                              context: context);
                        }
                      },
                    );
                  },
                  child: Text(
                    "ブロック",
                    style: TextStyle(
                        color: CustomColors.whiteMain,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: CustomColors.brownSub,
            icon: Icon(
              Icons.more_horiz,
              size: 35,
              color: CustomColors.whiteMain,
            ),
          );
