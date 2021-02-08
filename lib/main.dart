import 'package:catter_app/app.dart';
import 'package:catter_app/presentation/base/base_model.dart';
import 'package:catter_app/presentation/email_login/email_login_model.dart';
import 'package:catter_app/presentation/new_member_registration/new_member_registration_model.dart';
import 'package:catter_app/presentation/nickname_registration/nickname_registration_model.dart';
import 'package:catter_app/presentation/profile_photo_registration/profile_photo_registration_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // need to run async method in main function
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final originalCheck = Provider.debugCheckInvalidValueType;
  Provider.debugCheckInvalidValueType = <T>(T value) {
    // ignore: unnecessary_type_check
    if (value is Object) return;
    originalCheck<T>(value);
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EmailLoginModel>(
          create: (_) => EmailLoginModel(),
        ),
        ChangeNotifierProvider<NewMemberRegistrationModel>(
          create: (_) => NewMemberRegistrationModel(),
        ),
        ChangeNotifierProvider<NicknameRegistrationModel>(
          create: (_) => NicknameRegistrationModel(),
        ),
        ChangeNotifierProvider<ProfilePhotoRegistrationModel>(
          create: (_) => ProfilePhotoRegistrationModel(),
        ),
        ChangeNotifierProvider<BaseModel>(
          create: (_) => BaseModel(),
        ),
      ],
      child: App(),
    ),
  );
}