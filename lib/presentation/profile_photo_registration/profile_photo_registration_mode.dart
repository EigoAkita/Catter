import 'dart:io';
import 'package:catter_app/repository/firebase_firestore_api/users_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhotoRegistrationModel extends ChangeNotifier {
  File imageFile;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProfilePhotoToFirebase() async {
    final String profilePhotoURL =await _uploadImageFile();

    await UsersApi().registerProfilePhoto(
      uid: _auth.currentUser.uid,
      profilePhoto: profilePhotoURL,
    );
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
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 3,),
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 10,
        iosUiSettings: IOSUiSettings(
          title: '編集',
        ),
      );

      //　プロフィール写真（W: 500, H:500 @2x）をインスタンス変数に保存
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

  Future<String> _uploadImageFile() async {
    if (imageFile == null) {
      return '';
    }

    String newProfilePhotoName = "profilePhoto_" +
        DateTime.now().toString() +
        "_" +
        this._auth.currentUser.uid +
        '.jpg';
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('users/${this._auth.currentUser.uid}/profilePhotos/' + newProfilePhotoName)
        .putFile(this.imageFile)
        .onComplete;
    final String newProfilePhotoURL = await snapshot.ref.getDownloadURL();
    return newProfilePhotoURL;
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
