import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersApi {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  ///users collectionに、uidとカウントを追加する
  Future setFirebaseUidAndCount({
    @required String uid,
  }) async {
    await _usersCollection.doc(uid).set(
      <String, dynamic>{
        'createdAt': DateTime.now(),
        'isFirstLogin': true,
        'likedCount': 0,
        'postedCount': 0,
      },
    );
  }

  ///users collectionに、emailを追加する
  Future setFirebaseEmail({
    @required String uid,
    @required dynamic email,
  }) async {
    await _usersCollection.doc(uid).collection('user_info').doc('email').set(
      <String, dynamic>{'email': email},
    );
  }

  ///users collectionに、ニックネームを登録する
  Future registerNickname({
    @required String uid,
    @required String nickname,
  }) async {
    await _usersCollection.doc(uid).update(
      <String, dynamic>{
        'displayName': nickname,
        'updatedAt': DateTime.now(),
      },
    );
  }

  ///users collectionに、プロフィール写真を追加する
  Future registerProfilePhoto({
    @required String uid,
    @required String profilePhoto,
  }) async {
    await _usersCollection.doc(uid).update(
      <String, dynamic>{
        'profilePhotoURL': profilePhoto,
        'updatedAt': DateTime.now(),
      },
    );
  }

  ///users collectionの、自分のプロフィールを変更する
  Future changeMyProfile({
    @required String uid,
    @required String newDisplayName,
    @required String newProfilePhoto,
  }) async {
    await _usersCollection.doc(uid).update(
      <String, dynamic>{
        'displayName': newDisplayName,
        'profilePhotoURL': newProfilePhoto,
        'updatedAt': DateTime.now(),
      },
    );
  }
}
