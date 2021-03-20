import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/profile_photo_registration/profile_photo_registration_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePhotoRegistrationPage extends StatelessWidget {

  final nicknameController = TextEditingController();
  final List variables = Variables.inputFormTemplateInRegistrationVariables;
  final picker = ImagePicker();
  final double radius = 170;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<ProfilePhotoRegistrationModel>(
      create: (_) => ProfilePhotoRegistrationModel(),
      child: Consumer<ProfilePhotoRegistrationModel>(
          builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.whiteMain,
                            ),
                            children: [
                              TextSpan(
                                text: 'プロフィール写真を\n',
                              ),
                              TextSpan(
                                text: '選んでね！',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            await model.showImagePicker();
                          },
                          child: model.imageFile != null
                              ? Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width: radius,
                                        height: radius,
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(170),
                                            ),
                                            depth: 1,
                                            color: CustomColors.brownSub,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: radius,
                                        height: radius,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: CustomColors.brownSub,
                                            width: 5,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundImage: FileImage(
                                            model.imageFile,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(170),
                                          ),
                                          depth: 1,
                                          color: CustomColors.brownSub,
                                        ),
                                        child: Container(
                                          width: radius,
                                          height: radius,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: CustomColors.brownSub,
                                              width: 5,
                                            ),
                                            color: CustomColors.whiteMain,
                                          ),
                                          child: Container(
                                            width: radius,
                                            height: radius,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 70,
                                        ),
                                        Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 30,
                                            color: CustomColors.grayMain,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: 110,
                        ),
                        Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                height: 60,
                                child: NeumorphicButton(
                                  child: Center(
                                    child: const Text(
                                      '登録完了',
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
                                    color: model.imageFile != null
                                        ? CustomColors.brownMain
                                        : CustomColors.grayMain,
                                    border: NeumorphicBorder(
                                      color: CustomColors.whiteMain,
                                      width: 3,
                                    ),
                                  ),
                                  onPressed: model.imageFile != null
                                      ? () async {
                                          model.startLoading();
                                          await model
                                              .addProfilePhotoToFirebase();
                                          model.endLoading();
                                          await Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BasePage(),
                                            ),
                                          );
                                        }
                                      : null,
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
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
