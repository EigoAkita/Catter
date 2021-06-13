import 'package:cloud_firestore/cloud_firestore.dart';

class PostComment {
  PostComment(DocumentSnapshot doc) {
    this.id = doc.data()['id'];
    this.userId = doc.data()['userId'];
    this.displayName = doc.data()['displayName'];
    this.profilePhotoURL = doc.data()['profilePhotoURL'];
    this.comment = doc.data()['comment'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.blockedUserId = doc.data()['blockedUserId'];
  }

  String id;
  String userId;
  String displayName;
  String profilePhotoURL;
  String comment;
  Timestamp createdAt;
  Timestamp updatedAt;
  List<dynamic> blockedUserId;
}
