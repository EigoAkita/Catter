import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/nickname_registration/widgets/nickname_registration_text_form_widget.dart';
import 'package:catter_app/presentation/profile_photo_registration/profile_photo_registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'nickname_registration_model.dart';

class NicknameRegistrationPage extends StatelessWidget {
  final nicknameController = TextEditingController();
  final List variables = Variables.inputFormTemplateInRegistrationVariables;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<NicknameRegistrationModel>(
      create: (_) => NicknameRegistrationModel(),
      child:
          Consumer<NicknameRegistrationModel>(builder: (context, model, child) {
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
                                text: 'ニックネームを\n',
                              ),
                              TextSpan(
                                text: '登録してね！',
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        nickNameRegistrationTextFormWidget(
                          nicknameModel: model,
                          errorTextModel: model.errorNickname,
                          isController: nicknameController,
                          inputFormTemplateInRegistrationVariables: variables[3]
                              ['value'],
                          context: context,
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
                                      '次へ',
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
                                    color: model.isNicknameValid
                                        ? CustomColors.brownMain
                                        : CustomColors.grayMain,
                                    border: NeumorphicBorder(
                                      color: CustomColors.whiteMain,
                                      width: 3,
                                    ),
                                  ),
                                  onPressed: model.isNicknameValid
                                      ? () async {
                                          model.startLoading();
                                          await model.registrationNickName(
                                            context: context,
                                            nickname: nicknameController.text,
                                          );
                                          model.endLoading();
                                          await Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePhotoRegistrationPage(),
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
            screenLoading(
              isLoading: model.isLoading,
            ),
          ],
        );
      }),
    );
  }
}
