import 'package:catter_app/app.dart';
import 'package:catter_app/presentation/base/base_model.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_model.dart';
import 'package:catter_app/presentation/cats_of_all_users/cats_of_all_users_model.dart';
import 'package:catter_app/presentation/email_login/email_login_model.dart';
import 'package:catter_app/presentation/forget_password/forget_password_model.dart';
import 'package:catter_app/presentation/my_favorite_post_screen/my_favorite_post_screen_model.dart';
import 'package:catter_app/presentation/my_liked_post_screen/my_liked_post_screen_model.dart';
import 'package:catter_app/presentation/my_post_screen/my_post_screen_model.dart';
import 'package:catter_app/presentation/my_profile/my_profile_model.dart';
import 'package:catter_app/presentation/my_profile_change/my_profile_change_model.dart';
import 'package:catter_app/presentation/new_member_registration/new_member_registration_model.dart';
import 'package:catter_app/presentation/nickname_registration/nickname_registration_model.dart';
import 'package:catter_app/presentation/profile_photo_registration/profile_photo_registration_model.dart';
import 'package:catter_app/presentation/ranking/ranking_model.dart';
import 'package:catter_app/presentation/setting/setting_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // need to run async method in main function
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
        ChangeNotifierProvider<BaseModel>(
          create: (_) => BaseModel(),
        ),
        ChangeNotifierProvider<CatPostsModel>(
          create: (_) => CatPostsModel(),
        ),
        ChangeNotifierProvider<CatsOfAllUsersModel>(
          create: (_) => CatsOfAllUsersModel(),
        ),
        ChangeNotifierProvider<EmailLoginModel>(
          create: (_) => EmailLoginModel(),
        ),
        ChangeNotifierProvider<ForgetPasswordModel>(
          create: (_) => ForgetPasswordModel(),
        ),
        ChangeNotifierProvider<MyFavoritePostScreenModel>(
          create: (_) => MyFavoritePostScreenModel(),
        ),
        ChangeNotifierProvider<MyLikedPostScreenModel>(
          create: (_) => MyLikedPostScreenModel(),
        ),
        ChangeNotifierProvider<MyPostScreenModel>(
          create: (_) => MyPostScreenModel(),
        ),
        ChangeNotifierProvider<MyProfileModel>(
          create: (_) => MyProfileModel(),
        ),
        ChangeNotifierProvider<MyProfileChangeModel>(
          create: (_) => MyProfileChangeModel(),
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
        ChangeNotifierProvider<RankingModel>(
          create: (_) => RankingModel(),
        ),
        ChangeNotifierProvider<SettingModel>(
          create: (_) => SettingModel(),
        ),
      ],
      child: App(),
    ),
  );
}