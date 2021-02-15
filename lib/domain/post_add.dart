import 'package:cloud_firestore/cloud_firestore.dart';

class PostAdd {
  final String id;
  String uid;
  String catName;
  String catType;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  String catPhotoURL;

  PostAdd._(
      this.id,
      this.uid,
      this.catName,
      this.catType,
      this.createdAt,
      this.updatedAt,
      this.catPhotoURL,
      );

  factory PostAdd.doc(DocumentSnapshot doc) {
    final data = doc.data();
    return PostAdd._(
      doc.id,
      data['uid'] as String,
      data['catName'] as String,
      data['catType'] as String,
      data['createdAt'] as Timestamp,
      data['updateAt'] as Timestamp,
      data['catPhotoURL'] as String,
    );
  }
}
