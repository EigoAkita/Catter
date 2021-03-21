import 'package:cloud_firestore/cloud_firestore.dart';

class MyFavoritePostScreen {
  MyFavoritePostScreen(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
    this.id = doc.id;
    this.userId = doc.data()['userId'];
    this.catName = doc.data()['catName'];
    this.catType = doc.data()['catType'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.favoriteAt = doc.data()['favoriteAt'];
    this.catPhotoURL = doc.data()['catPhotoURL'];
  }

  String id;
  String userId;
  String catName;
  String catType;
  Timestamp createdAt;
  Timestamp updatedAt;
  Timestamp favoriteAt;
  String catPhotoURL;
  DocumentReference documentReference;
}
