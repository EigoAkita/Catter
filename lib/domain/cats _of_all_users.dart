import 'package:cloud_firestore/cloud_firestore.dart';

class CatsOfAllUsers {
  CatsOfAllUsers(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
    this.id = doc.id;
    this.userId = doc.data()['userId'];
    this.createdAt = doc.data()['createdAt'];
    this.updatedAt = doc.data()['updatedAt'];
    this.catName = doc.data()['catName'];
    this.catPhotoURL = doc.data()['catPhotoURL'];
    this.catType = doc.data()['catType'];
    this.profilePhotoURL = doc.data()['profilePhotoURL'];
    this.displayName = doc.data()['displayName'];
    this.favoriteAt = doc.data()['favoriteAt'];
    this.likedAt = doc.data()['likedAt'];
    this.blockedUserId = doc.data()['blockedUserId'];
    this.likeUserId = doc.data()['likeUserId'];
    this.commentCount = doc.data()['commentCount'];
    this.likePhotoCount = doc.data()['likePhotoCount'];
    this.isLikePhotos = true;
    this.isFavoritePhotos = true;
  }

  String id;
  String userId;
  Timestamp createdAt;
  Timestamp updatedAt;
  String catName;
  String catPhotoURL;
  String catType;
  String profilePhotoURL;
  String displayName;
  bool isFavoritePhotos;
  bool isLikePhotos;
  Timestamp favoriteAt;
  Timestamp likedAt;
  List<dynamic> blockedUserId;
  List<dynamic> likeUserId;
  int commentCount;
  int likePhotoCount;
  DocumentReference documentReference;

}
