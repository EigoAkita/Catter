import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/email_login/email_login_page.dart';
import 'package:catter_app/repository/firebase_auth.api.dart';
import 'package:flutter/material.dart';
import 'config/custom_colors.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: CustomColors.brownMain),
      home: FutureBuilder(
        future: FirebaseAuthApi().isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return BasePage();
          } else {
            return EmailLoginPage();
          }
        },
      ),
    );
  }
}
