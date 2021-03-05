import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/email_login/email_login_page.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:catter_app/presentation/my_profile/my_profile_model.dart';
import 'package:catter_app/presentation/setting/setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  final nicknameController = TextEditingController();
  final List variables = Variables.inputFormTemplateInRegistrationVariables;
  final double radius = 130;

  List<String> myProfileTextLists = <String>[
    '利用規約',
    'プライバシーポリシー',
    'ログアウト',
    '退会',
  ];

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<SettingModel>(
      create: (_) => SettingModel(),
      child: Consumer<MyProfileModel>(builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    '設定',
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BasePage(),
                        ),
                      );
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          const teamsOfServiceURL =
                              'https://kiyac.app/termsOfService/RnJ1enYAKSz3isHCTNWv';
                          if (await canLaunch(teamsOfServiceURL)) {
                            await launch(teamsOfServiceURL);
                          } else {
                            errorShowDialog(
                              loginErrorText: 'エラーが発生しました',
                              context: context,
                            );
                          }
                        },
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
                                        Icons.sticky_note_2_outlined,
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
                        onTap: () async {
                          const teamsOfServiceURL =
                              'https://kiyac.app/plivacypolicy/77AoBVZzhnrpfVvvMHN4';
                          if (await canLaunch(teamsOfServiceURL)) {
                            await launch(teamsOfServiceURL);
                          } else {
                            errorShowDialog(
                              loginErrorText: 'エラーが発生しました',
                              context: context,
                            );
                          }
                        },
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
                                        Icons.privacy_tip,
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
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.BOTTOMSLIDE,
                            dialogType: DialogType.QUESTION,
                            body: Center(
                              child: Text(
                                'ログアウトしますか？',
                                style: TextStyle(
                                  color: CustomColors.grayMain,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            btnCancelOnPress: () {},
                            btnCancelColor: CustomColors.brownMain,
                            btnCancelText: 'いいえ',
                            btnOkOnPress: () async {
                              model.startLoading();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailLoginPage(),
                                ),
                              );
                              model.endLoading();
                            },
                            btnOkColor: CustomColors.brownMain,
                            btnOkText: 'はい',
                            buttonsBorderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          )..show();
                        },
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
                                        FlutterIcons.exit_to_app_mco,
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
