import 'package:cloud_firestore/cloud_firestore.dart';

class PostAdd {
  PostAdd(DocumentSnapshot doc) {
    this.id = doc.id;
    this.userId = doc.data()['userId'];
    this.catName = doc.data()['catName'];
    this.catType = doc.data()['catType'];
    this.profilePhotoURL = doc.data()['profilePhotoURL'];
    this.displayName = doc.data()['displayName'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.catPhotoURL = doc.data()['catPhotoURL'];
  }
  String id;
  String userId;
  String catName;
  String catType;
  String profilePhotoURL;
  String displayName;
  Timestamp createdAt;
  Timestamp updatedAt;
  String catPhotoURL;
}

