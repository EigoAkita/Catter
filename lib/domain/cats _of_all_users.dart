import 'package:cloud_firestore/cloud_firestore.dart';

class CatsOfAllUsers {
  CatsOfAllUsers(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
    this.id = doc.id;
    this.uid = doc.data()['uid'];
    this.createdAt= doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.catName = doc.data()['catName'];
    this.catPhotoURL = doc.data()['catPhotoURL'];
    this.catType = doc.data()['catType'];
  }

  String id;
  String uid;
  Timestamp createdAt;
  Timestamp updatedAt;
  String catName;
  String catPhotoURL;
  String catType;
  DocumentReference documentReference;
}