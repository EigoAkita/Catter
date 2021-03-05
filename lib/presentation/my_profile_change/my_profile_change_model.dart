import 'dart:io';
import 'package:catter_app/repository/firebase_firestore_api/users_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyProfileChangeModel extends ChangeNotifier {
  bool isLoading = false;
  String newDisplayName = '';
  bool isNewDisplayNameValid = false;
  String errorNewDisplayName = '';
  File imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future changeProfileToFirebase() async {
    if (this.imageFile != null) {
      await _uploadImageFile();
    }

    final String newProfilePhotoURL = await _uploadImageFile();

    await UsersApi().changeMyProfile(
      uid: this._auth.currentUser.uid,
      newDisplayName: this.newDisplayName,
      newProfilePhoto: newProfilePhotoURL,
    );

    notifyListeners();
  }

  Future<String> _uploadImageFile() async {
    String newProfilePhotoName = "newProfilePhoto_" +
        DateTime.now().toString() +
        "_" +
        this._auth.currentUser.uid +
        '.jpg';
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('users/${this._auth.currentUser.uid}/newProfilePhotos/' +
            newProfilePhotoName)
        .putFile(this.imageFile)
        .onComplete;
    final String newProfilePhotoURL = await snapshot.ref.getDownloadURL();
    return newProfilePhotoURL;
  }

  Future<void> showImagePicker() async {
    ImagePicker _picker = ImagePicker();

    try {
      PickedFile _pickedFile =
          await _picker.getImage(source: ImageSource.gallery);

      // 選択した画像ファイルのパスを保存
      File _pickedImage = File(_pickedFile.path);

      // 画像をアスペクト比 3:3 で 切り抜く
      File _croppedImageFile = await ImageCropper.cropImage(
        sourcePath: _pickedImage.path,
        maxHeight: 150,
        aspectRatio: CropAspectRatio(
          ratioX: 3,
          ratioY: 3,
        ),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 10,
        iosUiSettings: IOSUiSettings(
          title: '編集',
        ),
      );

      //　プロフィール写真（W: 1000, H:500 @2x）をインスタンス変数に保存
      this.imageFile = await FlutterNativeImage.compressImage(
        _croppedImageFile.path,
        targetWidth: 500,
        targetHeight: 500,
      );
    } catch (e) {
      print('Image Picker から画像の圧縮の過程でエラーが発生');
      print(e.toString());
      return;
    }

    notifyListeners();
  }

  void changeDisplayName(text) {
    this.newDisplayName = text;
    if (text.length == 0) {
      isNewDisplayNameValid = false;
      this.errorNewDisplayName = '新しいニックネームを入力して下さい。';
    } else if (text.length > 6) {
      isNewDisplayNameValid = false;
      this.errorNewDisplayName = '新しいニックネームは6文字以内です。';
    } else {
      isNewDisplayNameValid = true;
      this.errorNewDisplayName = '';
    }
    notifyListeners();
  }

  void startLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    this.isLoading = false;
    notifyListeners();
  }
}
