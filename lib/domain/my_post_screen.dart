import 'package:cloud_firestore/cloud_firestore.dart';

class MyPostScreen {
  MyPostScreen(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
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
  DocumentReference documentReference;
}
