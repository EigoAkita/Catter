import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/main_dialog.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/email_login/email_login_page.dart';
import 'package:catter_app/presentation/email_login/widgets/error_show_dialog.dart';
import 'package:catter_app/presentation/my_profile/my_profile_model.dart';
import 'package:catter_app/presentation/my_profile/widgets/transition_button.dart';
import 'package:catter_app/presentation/setting/setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  final double radius = 130;

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
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () async {
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
                        transitionIcon: Icon(
                          MaterialCommunityIcons.book_open,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: '利用規約',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () async {
                          final teamsOfServiceURL =
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
                        transitionIcon: Icon(
                          MaterialCommunityIcons.shield_alert,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: 'プライバシーポリシー',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      transitionButton(
                        tapAction: () {
                          mainDialog(
                            isOKOnly: true,
                            context: context,
                            animType: AnimType.BOTTOMSLIDE,
                            dialogType: DialogType.QUESTION,
                            dialogText: 'ログアウトしますか？',
                            subOKText: 'はい',
                            cancelPress: () {},
                            okPress: () async {
                              model.startLoading();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailLoginPage(),
                                ),
                              );
                              model.endLoading();
                            },
                          );
                        },
                        transitionIcon: Icon(
                          MaterialCommunityIcons.exit_to_app,
                          size: 30,
                          color: CustomColors.brownMain,
                        ),
                        myProfileText: 'ログアウト',
                      ),
                    ],
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
