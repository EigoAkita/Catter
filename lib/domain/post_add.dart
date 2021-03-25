import 'package:cloud_firestore/cloud_firestore.dart';

class PostAdd {
  PostAdd(DocumentSnapshot doc) {
    this.id = doc.id;
    this.userId = doc.data()['userId'];
    this.catName = doc.data()['catName'];
    this.catType = doc.data()['catType'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.catPhotoURL = doc.data()['catPhotoURL'];
  }
  String id;
  String userId;
  String catName;
  String catType;
  Timestamp createdAt;
  Timestamp updatedAt;
  String catPhotoURL;
}

