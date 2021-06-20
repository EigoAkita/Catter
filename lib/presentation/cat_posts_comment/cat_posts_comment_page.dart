import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/cat_posts_comment/cat_posts_comment_model.dart';
import 'package:catter_app/presentation/cat_posts_comment/widgets/comment_tile.dart';
import 'package:catter_app/presentation/user_posts/user_posts_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CatPostsCommentPage extends StatelessWidget {
  CatPostsCommentPage({
    @required this.catPhotoURL,
    @required this.displayName,
    @required this.profilePhotoURL,
    @required this.catName,
    @required this.catType,
    @required this.postId,
  });

  String profilePhotoURL;
  String displayName;
  String catPhotoURL;
  String catName;
  String catType;
  String postId;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return ChangeNotifierProvider<CatPostsCommentModel>(
      create: (_) => CatPostsCommentModel(
        postId: postId,
      )..fetchPostCommentsRealTime(),
      child: Consumer<CatPostsCommentModel>(
        builder: (context, model, child) {
          return Stack(
            children: <Widget>[
              SizedBox(
                height: data.size.height,
                width: data.size.width,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    elevation: 3,
                    backgroundColor: CustomColors.brownSub,
                    brightness: Brightness.dark,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        profilePhotoURL != null
                            ? Container(
                                width: 40,
                                height: 40,
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
                              )
                            : Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  color: CustomColors.whiteMain,
                                ),
                                child: Icon(
                                  MaterialCommunityIcons.cat,
                                  color: CustomColors.brownMain,
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        displayName != null
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
                      ],
                    ),
                  ),
                  body: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      if (details.delta.dx > 20) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: KeyboardActions(
                      config: _buildConfig(context),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: bottomSpace + data.size.height / 2,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 150,
                              height: 150,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10),
                                  ),
                                  depth: 3,
                                  color: CustomColors.brownSub,
                                  border: NeumorphicBorder(
                                    color: CustomColors.brownSub,
                                    width: 5,
                                  ),
                                ),
                                child: Image(
                                  image: NetworkImage(
                                    catPhotoURL,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15,
                                        ),
                                        NeumorphicText(
                                          '名前 : $catName',
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
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 15,
                                        ),
                                        NeumorphicText(
                                          '種類 : $catType',
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
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Neumorphic(
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      depth: 1,
                                      color: CustomColors.whiteMain,
                                      shadowDarkColorEmboss: Colors.blueGrey,
                                    ),
                                    child: TextFormField(
                                      focusNode: _focusNodeComment,
                                      keyboardType: TextInputType.multiline,
                                      initialValue: model.comment,
                                      onChanged: (text) {
                                        model.changePostsComment(text);
                                      },
                                      minLines: 1,
                                      maxLines: null,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'コメント',
                                        alignLabelWithHint: false,
                                        filled: true,
                                        fillColor: CustomColors.whiteMain,
                                        border: InputBorder.none,
                                        errorText: model.errorComment == ''
                                            ? null
                                            : model.errorComment,
                                        errorMaxLines: 5,
                                      ),
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (model.comment.isNotEmpty &&
                                          model.errorComment.isEmpty) {
                                        model.startLoading();
                                        await model.addCommentToFirebase();
                                        model.endLoading();
                                      }
                                    },
                                    child: NeumorphicIcon(
                                      Icons.send_rounded,
                                      size: 35,
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        depth: 1,
                                        color: Colors.pinkAccent,
                                        shadowDarkColorEmboss: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: data.size.height * 0.5,
                              width: data.size.width,
                              child: Neumorphic(
                                style: NeumorphicStyle(
                                  depth: 1,
                                ),
                                child: Container(
                                  color: CustomColors.brownSub,
                                  child: Stack(
                                    children: <Widget>[
                                      Scrollbar(
                                        child: ListView(
                                          padding: const EdgeInsets.all(10),
                                          children: model.postCommentList
                                              .map(
                                                (commentList) => Stack(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Visibility(
                                                          visible: commentList
                                                                  .userId ==
                                                              model.uid,
                                                          child: commentTile(
                                                            model: model,
                                                            profilePhotoURL:
                                                                commentList
                                                                    .profilePhotoURL,
                                                            displayName:
                                                                commentList
                                                                    .displayName,
                                                            comment: commentList
                                                                .comment,
                                                            isCurrentUser: true,
                                                            id: commentList.id,
                                                            uid: model.uid,
                                                            userImageTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UserPostsPage(
                                                                    userId: commentList
                                                                        .userId,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: commentList
                                                                  .userId !=
                                                              model.uid,
                                                          child: commentTile(
                                                            model: model,
                                                            profilePhotoURL:
                                                                commentList
                                                                    .profilePhotoURL,
                                                            displayName:
                                                                commentList
                                                                    .displayName,
                                                            comment: commentList
                                                                .comment,
                                                            isCurrentUser:
                                                                false,
                                                            id: commentList.id,
                                                            userId: commentList
                                                                .userId,
                                                            userImageTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          UserPostsPage(
                                                                    userId: commentList
                                                                        .userId,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      Visibility(
                                        visible: model.postCommentList.isEmpty,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  'コメントがありません',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        CustomColors.blackMain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
        },
      ),
    );
  }

  final FocusNode _focusNodeComment = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: CustomColors.graySub,
      nextFocus: false,
      actions: [
        _keyboardActionItems(_focusNodeComment),
      ],
    );
  }

  _keyboardActionItems(_focusNode) {
    return KeyboardActionsItem(
      focusNode: _focusNode,
      toolbarButtons: [
        (node) {
          return customDoneButton(_focusNode);
        },
      ],
    );
  }

  Widget customDoneButton(FocusNode _focusNode) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Row(
        children: <Widget>[
          Text(
            '完了',
            style: TextStyle(
              color: CustomColors.brownSub,
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
