import 'package:cloud_firestore/cloud_firestore.dart';

class Ranking {
  Ranking(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
    this.id = doc.id;
    this.uid = doc.data()['uid'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.displayName = doc.data()['displayName'];
    this.profilePhotoURL = doc.data()['profilePhotoURL'];
    this.likedCount = doc.data()['likedCount'];
  }

  String id;
  String uid;
  Timestamp createdAt;
  Timestamp updatedAt;
  String displayName;
  String profilePhotoURL;
  int likedCount;
  DocumentReference documentReference;
}
