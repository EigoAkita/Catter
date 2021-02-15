import 'dart:io';
import 'package:catter_app/config/cat_type.dart';
import 'package:catter_app/domain/post_add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CatPostsModel extends ChangeNotifier {
  PostAdd postAdd;
  bool isLoading = false;
  String catName = '';
  var catType = '';
  bool isCatNameValid = false;
  bool isCatTypeValid = false;
  String errorCatName = '';
  String errorCatType = '';
  File imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future addPostsToFirebase() async {
    if (this.imageFile != null) {
      await _uploadPostImage();
    }

    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    WriteBatch _batch = _fireStore.batch();

    String _generatedId = _fireStore
        .collection('posts')
        .doc()
        .id;

    DocumentReference _myUserDoc =
        _fireStore.collection('users').doc(this._auth.currentUser.uid);
    DocumentSnapshot _snap = await _myUserDoc.get();
    int postedCount = _snap.data()['postedCount'];

    DocumentReference _myPostDoc = _fireStore
        .collection('posts')
        .doc(_generatedId);

    final String postImageURL = await _uploadPostImage();

    _batch.set(_myPostDoc, {
      'id': _generatedId,
      'uid': this._auth.currentUser.uid,
      'catName': this.catName,
      'catType': this.catType,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'catPhotoURL': postImageURL,
    });

    _batch.update(_myUserDoc, {'postedCount': postedCount + 1});

    await _batch.commit();

    notifyListeners();
  }

  Future<String> _uploadPostImage() async {
    String _fileName = "postImage_" +
        DateTime.now().toString() +
        "_" +
        _auth.currentUser.uid +
        '.jpg';
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage
        .ref()
        .child('posts/' + _auth.currentUser.uid + '/postImages/' + _fileName)
        .putFile(this.imageFile)
        .onComplete;
    final String imagePhoto = await snapshot.ref.getDownloadURL();
    return imagePhoto;
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

  void changeCatName(text) {
    this.catName = text;
    if (text.length == 0) {
      isCatNameValid = false;
      this.errorCatName = '猫の名前を入力して下さい。';
    } else if (text.length > 6) {
      isCatNameValid = false;
      this.errorCatName = '猫の名前は6文字以内です。';
    } else {
      isCatNameValid = true;
      this.errorCatName = '';
    }
    notifyListeners();
  }

  void changeCatType(text) {
    this.catType = text;
    if (catTypes.contains(text)) {
      isCatTypeValid = true;
      this.errorCatType = '';
    } else {
      isCatTypeValid = false;
      this.errorCatType = '猫の種類は選択ボタンの中からお選びください。';
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
