import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/config/main_dialog.dart';
import 'package:catter_app/config/screen_loading.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/my_profile_change/my_profile_change_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class MyProfileChangePage extends StatelessWidget {
  final newDisplayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<MyProfileChangeModel>(
      create: (_) => MyProfileChangeModel(),
      child: Consumer<MyProfileChangeModel>(builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'マイプロフィール',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BasePage(),
                        ),
                      );
                    },
                  ),
                ),
                body: Center(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.delta.dx > 20) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
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
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width /
                                            1.15,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Expanded(
                                            flex: 1,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 11,
                                            child: Text(
                                              '新しいニックネーム',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: CustomColors.whiteMain,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            flex: 1,
                                            child: SizedBox(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Expanded(
                                            flex: 1,
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 11,
                                            child: Neumorphic(
                                              style: const NeumorphicStyle(
                                                shape: NeumorphicShape.flat,
                                                depth: 1,
                                                color: CustomColors.whiteMain,
                                                shadowDarkColorEmboss:
                                                    Colors.blueGrey,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  TextFormField(
                                                    textAlign: TextAlign.center,
                                                    controller:
                                                        newDisplayNameController,
                                                    onChanged: (text) {
                                                      model.changeDisplayName(
                                                          text);
                                                    },
                                                    obscureText: false,
                                                    maxLines: 1,
                                                    decoration: InputDecoration(
                                                      errorText: model
                                                                  .errorNewDisplayName ==
                                                              ''
                                                          ? null
                                                          : model
                                                              .errorNewDisplayName,
                                                      filled: true,
                                                      fillColor: CustomColors
                                                          .whiteMain,
                                                      border: InputBorder.none,
                                                      hintText: 'ラテ丸',
                                                      hintStyle: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                ],
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
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        '新しいプロフィール写真',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColors.whiteMain,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
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
                                                width: 200,
                                                height: 200,
                                                child: Neumorphic(
                                                  style: NeumorphicStyle(
                                                    depth: 1,
                                                    color:
                                                        CustomColors.brownSub,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: 200,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        CustomColors.brownSub,
                                                    width: 5,
                                                  ),
                                                ),
                                                child: Image(
                                                  image: FileImage(
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
                                                  depth: 1,
                                                  color: CustomColors.brownSub,
                                                ),
                                                child: Container(
                                                  width: 200,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          CustomColors.brownSub,
                                                      width: 5,
                                                    ),
                                                    color:
                                                        CustomColors.whiteMain,
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 85,
                                                ),
                                                Center(
                                                  child: Icon(
                                                    Icons.add_a_photo,
                                                    size: 30,
                                                    color:
                                                        CustomColors.grayMain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 8,
                                child: NeumorphicButton(
                                  child: Center(
                                    child: const Text(
                                      '変更する',
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
                                    color:
                                        model.isNewDisplayNameValid == true &&
                                                model.imageFile != null
                                            ? CustomColors.brownMain
                                            : CustomColors.grayMain,
                                    border: NeumorphicBorder(
                                      color: CustomColors.whiteMain,
                                      width: 3,
                                    ),
                                  ),
                                  onPressed:
                                      model.isNewDisplayNameValid == true &&
                                              model.imageFile != null
                                          ? () async {
                                              mainDialog(
                                                isOKOnly: true,
                                                context: context,
                                                animType: AnimType.BOTTOMSLIDE,
                                                dialogType: DialogType.QUESTION,
                                                dialogText: 'プロフィールを変更しますか？',
                                                subOKText: 'はい',
                                                cancelPress: () {},
                                                okPress: () async {
                                                  model.startLoading();
                                                  await model
                                                      .changeProfileToFirebase();
                                                  model.endLoading();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BasePage(),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          : null,
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
