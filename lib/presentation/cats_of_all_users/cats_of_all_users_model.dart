import 'package:catter_app/domain/cats%20_of_all_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CatsOfAllUsersModel extends ChangeNotifier {
  CatsOfAllUsers catsOfAllUsers;
  String id = '';
  String uid = FirebaseAuth.instance.currentUser.uid;
  String anotherCatName;
  String anotherCatType;
  String anotherCatPhotoURL;
  bool isLoading = false;
  bool isFavorite = false;
  bool isLike = false;
  bool isFavoritePhotos = false;
  bool isLikePhotos = false;
  List<CatsOfAllUsers> catsOfAllUsersList = [];

  Future<void> fetchPosts() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance.collection('posts').get();
    final docs = snapshot.docs;
    final catsOfAllUsersList = docs.map((doc) => CatsOfAllUsers(doc)).toList();
    this.catsOfAllUsersList = catsOfAllUsersList;
    print(catsOfAllUsers.catPhotoURL);
    notifyListeners();
  }

  // お気に入りボタンを押した時の処理
  Future<void> pressedFavoriteButton() async {
    // お気に入りの ON/OFF を切り替える
    switchFavoriteState(this.isFavoritePhotos);

    // 対象をお気に入りから削除する
    if (this.isFavoritePhotos) {
      await FirebaseFirestore.instance
          .collection('users/${this.uid}/favorite_posts')
          .doc(this.catsOfAllUsers.id)
          .delete();
    }
    // 対象をお気に入りに追加する
    else {
      DocumentSnapshot _doc;

      if (this.catsOfAllUsers.id.startsWith('posts_')) {
        _doc = await FirebaseFirestore.instance
            .collection('posts')
            .doc(this.catsOfAllUsers.id)
            .get();
      } else {
        _doc = await FirebaseFirestore.instance
            .collection('users/${this.uid}/posts')
            .doc(this.catsOfAllUsers.id)
            .get();
      }

      Map _fields = _doc.data();
      _fields['favoriteAt'] = FieldValue.serverTimestamp();

      try {
        await FirebaseFirestore.instance
            .collection('users/${this.uid}/favorite_posts')
            .doc(this.catsOfAllUsers.id)
            .set(_fields);
      } catch (e) {
        print('お気に入りの追加時にエラーが発生');
        print(e);
      }
    }
  }

  // いいねボタンを押した時の処理
  Future<void> pressedLikeButton() async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    WriteBatch _batch = _fireStore.batch();

    DocumentReference _anotherUserDoc =
        _fireStore.collection('users').doc(this.uid);
    DocumentSnapshot _snap = await _anotherUserDoc.get();
    int likedCount = _snap.data()['likedCount'];

    // いいねの ON/OFF を切り替える
    switchLikeState(this.isLikePhotos);

    // 対象をいいねから削除する
    if (this.isLikePhotos) {
      await FirebaseFirestore.instance
          .collection('users/${this.uid}/like_posts')
          .doc(this.catsOfAllUsers.id)
          .delete();

      _batch.update(_anotherUserDoc, {'likedCount': likedCount - 1});

      await _batch.commit();
    }
    // 対象をいいねに追加する
    else {
      DocumentSnapshot _doc;

      if (this.catsOfAllUsers.id.startsWith('posts_')) {
        _doc = await FirebaseFirestore.instance
            .collection('posts')
            .doc(this.catsOfAllUsers.id)
            .get();
      } else {
        _doc = await FirebaseFirestore.instance
            .collection('users/${this.uid}/posts')
            .doc(this.catsOfAllUsers.id)
            .get();
      }

      Map _fields = _doc.data();
      _fields['likedAt'] = FieldValue.serverTimestamp();

      try {
        await FirebaseFirestore.instance
            .collection('users/${this.uid}/like_posts')
            .doc(this.catsOfAllUsers.id)
            .set(_fields);

        _batch.update(_anotherUserDoc, {'likedCount': likedCount + 1});

        await _batch.commit();
      } catch (e) {
        print('いいねの追加時にエラーが発生');
        print(e);
      }
    }
  }

  void switchFavoriteState(bool input) {
    this.isFavoritePhotos = !input;
    notifyListeners();
  }

  void switchLikeState(bool input) {
    this.isLikePhotos = !input;
    notifyListeners();
  }

  void startLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    this.isLoading = false;
    notifyListeners();
  }
}
