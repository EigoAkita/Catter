import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfile{
  MyProfile(DocumentSnapshot doc){
    this.id =doc.id;
    this.userId = doc.data()['userId'];
    this.displayName = doc.data()['displayName'];
    this.email = doc.data()['email'];
    this.createdAt = doc.data()['createdAt'];
    this.updateAt= doc.data()['updateAt'];
    this.profilePhotoURL = doc.data()['profilePhotoURL'];
    this.likedCount = doc.data()['likedCount'];
    this.postedCount = doc.data()['postedCount'];
  }

  String id;
  String userId;
  String displayName;
  String email;
  Timestamp createdAt;
  Timestamp updateAt;
  String profilePhotoURL;
  int likedCount;
  int postedCount;
}
