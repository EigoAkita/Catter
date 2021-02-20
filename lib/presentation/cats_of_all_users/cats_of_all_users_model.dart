import 'package:catter_app/domain/cats%20_of_all_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CatsOfAllUsersModel extends ChangeNotifier {
  String uid = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  bool isFavoritePhotos = false;
  bool isLikePhotos = false;
  List<CatsOfAllUsers> catsOfAllUsersList = [];

  Future<void> fetchPosts() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance.collection('posts').get();
    final docs = snapshot.docs;
    final catsOfAllUsersList = docs.map((doc) => CatsOfAllUsers(doc)).toList();
    this.catsOfAllUsersList = catsOfAllUsersList;
    endLoading();
    notifyListeners();
  }

  Future<void> fetchPostsRealTime() async {
    startLoading();
    final snapshots =
        FirebaseFirestore.instance.collection('posts').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final catsOfAllUsersList =
          docs.map((doc) => CatsOfAllUsers(doc)).toList();
      catsOfAllUsersList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.catsOfAllUsersList = catsOfAllUsersList;
      endLoading();
      notifyListeners();
    });
    isFavoritePhotos = true;
    isLikePhotos = true;
  }

  // お気に入りボタンを押した時の処理
  Future<void> pressedFavoriteButton({
    @required String id,
    @required String uid,
  }) async {
    // お気に入りの ON/OFF を切り替える
    switchFavoriteState(this.isFavoritePhotos);

    // 対象をお気に入りから削除する
    if (this.isFavoritePhotos) {
      await FirebaseFirestore.instance
          .collection('users/$uid/favorite_posts')
          .doc(id)
          .delete();
    }
    // 対象をお気に入りに追加する
    else {
      DocumentSnapshot _doc;

      _doc = await FirebaseFirestore.instance.collection('posts').doc(id).get();

      Map _fields = _doc.data();
      _fields['favoriteAt'] = FieldValue.serverTimestamp();

      try {
        await FirebaseFirestore.instance
            .collection('users/$uid/favorite_posts')
            .doc(id)
            .set(_fields);
      } catch (e) {
        print('お気に入りの追加時にエラーが発生');
        print(e);
      }
    }
  }

  // いいねボタンを押した時の処理
  Future<void> pressedLikeButton({
    @required String id,
    @required String uid,
  }) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    WriteBatch _batch = _fireStore.batch();

    DocumentReference _anotherUserDoc = _fireStore.collection('users').doc(uid);
    DocumentSnapshot _snap = await _anotherUserDoc.get();
    int likedCount = _snap.data()['likedCount'];

    // いいねの ON/OFF を切り替える
    switchLikeState(this.isLikePhotos);

    // 対象をいいねから削除する
    if (this.isLikePhotos) {
      await FirebaseFirestore.instance
          .collection('users/$uid/like_posts')
          .doc(id)
          .delete();

      _batch.update(_anotherUserDoc, {'likedCount': likedCount - 1});

      if (likedCount < 0) {
        _batch.update(_anotherUserDoc, {'likedCount': 0});
      }

      await _batch.commit();
    }
    // 対象をいいねに追加する
    else {
      DocumentSnapshot _doc;

      _doc = await FirebaseFirestore.instance.collection('posts').doc(id).get();

      Map _fields = _doc.data();
      _fields['likedAt'] = FieldValue.serverTimestamp();

      try {
        await FirebaseFirestore.instance
            .collection('users/$uid/like_posts')
            .doc(id)
            .set(_fields);

        _batch.update(_anotherUserDoc, {'likedCount': likedCount + 1});

        await _batch.commit();
      } catch (e) {
        print('いいねの追加時にエラーが発生');
        print(e);
      }
    }
  }

  Future<void> deleteMyPost({
    @required String id,
    @required String uid,
  }) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    WriteBatch _batch = _fireStore.batch();

    await FirebaseFirestore.instance.collection('posts').doc(id).delete();

    DocumentReference _myUserDoc = _fireStore.collection('users').doc(uid);
    DocumentSnapshot _snap = await _myUserDoc.get();
    int postedCount = _snap.data()['postedCount'];

    _batch.update(_myUserDoc, {'postedCount': postedCount - 1});

    if (postedCount < 0) {
      _batch.update(_myUserDoc, {'postedCount': 0});
    }

    await _batch.commit();
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
