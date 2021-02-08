import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/email_login/email_login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: NeumorphicButton(
                    child: Center(
                      child: const Text(
                        '戻る',
                        style: TextStyle(
                          color: CustomColors.whiteMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(15),
                      ),
                      color: CustomColors.brownSub,
                      border: NeumorphicBorder(
                        color: CustomColors.whiteMain,
                        width: 3,
                      ),
                    ),
                    onPressed: () async {
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailLoginPage(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
