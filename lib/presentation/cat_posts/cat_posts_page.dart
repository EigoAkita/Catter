import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catter_app/config/cat_type.dart';
import 'package:catter_app/config/custom_colors.dart';
import 'package:catter_app/presentation/base/base_page.dart';
import 'package:catter_app/presentation/cat_posts/cat_posts_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class CatPostsPage extends StatelessWidget {
  final catNameController = TextEditingController();
  final catTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return ChangeNotifierProvider<CatPostsModel>(
      create: (_) => CatPostsModel(),
      child: Consumer<CatPostsModel>(builder: (context, model, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: data.size.height,
              width: data.size.width,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    '投稿',
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
                                      MediaQuery.of(context).size.width / 1.15,
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
                                            '猫の名前',
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
                                                  controller: catNameController,
                                                  onChanged: (text) {
                                                    model.changeCatName(text);
                                                  },
                                                  obscureText: false,
                                                  maxLines: 1,
                                                  decoration: InputDecoration(
                                                    errorText:
                                                        model.errorCatName == ''
                                                            ? null
                                                            : model
                                                                .errorCatName,
                                                    filled: true,
                                                    fillColor:
                                                        CustomColors.whiteMain,
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
                                      '猫の種類',
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
                                    flex: 4,
                                    child: Neumorphic(
                                      style: const NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        depth: 1,
                                        color: CustomColors.whiteMain,
                                        shadowDarkColorEmboss: Colors.blueGrey,
                                      ),
                                      child: TextFormField(
                                        controller: catTypeController,
                                        onChanged: (text) {
                                          model.changeCatType(text);
                                        },
                                        obscureText: false,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          errorMaxLines: 2,
                                          errorText: model.errorCatType == ''
                                              ? null
                                              : model.errorCatType,
                                          filled: true,
                                          fillColor: CustomColors.whiteMain,
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 48,
                                      child: NeumorphicButton(
                                        child: Center(
                                          child: Text(
                                            '選択',
                                            style: TextStyle(
                                              color: CustomColors.whiteMain,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        style: const NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          depth: 1,
                                          color: CustomColors.brownMain,
                                          shadowDarkColorEmboss:
                                              Colors.blueGrey,
                                        ),
                                        onPressed: () {
                                          showMaterialRadioPicker(
                                            context: context,
                                            confirmText: '決定',
                                            onConfirmed: () {
                                              TextFormField(
                                                controller: catTypeController
                                                  ..text = model.catType,
                                              );
                                            },
                                            cancelText: '戻る',
                                            headerTextColor:
                                                CustomColors.whiteMain,
                                            headerColor: CustomColors.brownMain,
                                            buttonTextColor:
                                                CustomColors.whiteMain,
                                            backgroundColor:
                                                CustomColors.brownSub,
                                            title: '猫の種類を選んでね！',
                                            items: catTypes,
                                            selectedItem: model.catType,
                                            onChanged: (text) =>
                                                model.catType = text,
                                          );
                                        },
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
                                      '猫の写真',
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
                                                  color: CustomColors.brownSub,
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
                                                  color: CustomColors.brownSub,
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
                                                  color: CustomColors.whiteMain,
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
                                                  color: CustomColors.grayMain,
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
                                    '投稿する',
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
                                  color: model.isCatNameValid == true &&
                                          catTypes.contains(model.catType) &&
                                          model.imageFile != null
                                      ? CustomColors.brownMain
                                      : CustomColors.grayMain,
                                  border: NeumorphicBorder(
                                    color: CustomColors.whiteMain,
                                    width: 3,
                                  ),
                                ),
                                onPressed: model.isCatNameValid == true &&
                                        catTypes.contains(model.catType) &&
                                        model.imageFile != null
                                    ? () async {
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.BOTTOMSLIDE,
                                          dialogType: DialogType.QUESTION,
                                          body: Center(
                                            child: Text(
                                              '猫の写真を投稿しますか？',
                                              style: TextStyle(
                                                color: CustomColors.grayMain,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          btnCancelOnPress: () {},
                                          btnCancelColor:
                                              CustomColors.brownMain,
                                          btnCancelText: 'いいえ',
                                          btnOkOnPress: () async {
                                            model.startLoading();
                                            await model.addPostsToFirebase();
                                            model.endLoading();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BasePage(),
                                              ),
                                            );
                                          },
                                          btnOkColor: CustomColors.brownMain,
                                          btnOkText: 'はい',
                                          buttonsBorderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        )..show();
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