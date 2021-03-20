import 'package:cloud_firestore/cloud_firestore.dart';

class PostAdd {
  PostAdd(DocumentSnapshot doc) {
    this.id = doc.id;
    this.uid = doc.data()['uid'];
    this.catName = doc.data()['catName'];
    this.catType = doc.data()['catType'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.catPhotoURL = doc.data()['catPhotoURL'];
  }
  String id;
  String uid;
  String catName;
  String catType;
  Timestamp createdAt;
  Timestamp updatedAt;
  String catPhotoURL;
}

