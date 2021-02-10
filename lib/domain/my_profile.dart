import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfile {
  final String id;
  final String uid;
  final String displayName;
  final String email;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  String profilePhotoURL;
  final int likedCount;
  final int postedCount;

  MyProfile._(
    this.id,
    this.uid,
    this.displayName,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.profilePhotoURL,
    this.likedCount,
    this.postedCount,
  );

  factory MyProfile.doc(DocumentSnapshot doc) {
    final data = doc.data();
    return MyProfile._(
      doc.id,
      data['uid'] as String,
      data['displayName'] as String,
      data['email'] as String,
      data['createdAt'] as Timestamp,
      data['updateAt'] as Timestamp,
      data['profilePhotoURL'] as String,
      data['likedCount'] as int,
      data['postedCount'] as int,
    );
  }
}
