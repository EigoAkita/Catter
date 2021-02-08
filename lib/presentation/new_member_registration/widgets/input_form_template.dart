import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/variables.dart';
import 'package:catter_app/presentation/new_member_registration/widgets/new_member_registration_text_form_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../new_member_registration_model.dart';

final List variables = Variables.inputFormTemplateInRegistrationVariables;
final mailController = TextEditingController();
final passwordController = TextEditingController();
final confirmController = TextEditingController();

Widget inputFormTemplate({
  @required NewMemberRegistrationModel model,
  @required BuildContext context,
}) {
  return Card(
    shadowColor: CustomColors.grayMain,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    color: CustomColors.brownSub,
    child: Column(
      children: [
        SizedBox(
          height: 40,
        ),
        newMemberRegistrationTextFormWidget(
          memberModel: model,
          visible: true,
          errorTextModel: model.errorMail,
          isController: mailController,
          inputFormTemplateInRegistrationVariables: variables[0]['value'],
          context: context,
          obscureText: false,
          inputFormText: 'メールアドレス',
          isHintText: true,
        ),
        SizedBox(
          height: 30,
        ),
        newMemberRegistrationTextFormWidget(
          memberModel: model,
          visible: true,
          errorTextModel: model.errorPassword,
          isController: passwordController,
          inputFormTemplateInRegistrationVariables: variables[1]['value'],
          context: context,
          obscureText: true,
          inputFormText: 'パスワード',
          isHintText: false,
        ),
        SizedBox(
          height: 30,
        ),
        newMemberRegistrationTextFormWidget(
          memberModel: model,
          visible: true,
          errorTextModel: model.errorPasswordConfirm,
          isController: confirmController,
          inputFormTemplateInRegistrationVariables: variables[2]['value'],
          context: context,
          obscureText: true,
          inputFormText: 'パスワード（確認）',
          isHintText: false,
        ),
        SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}
