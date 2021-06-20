import 'package:catter_app/domain/cats%20_of_all_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CatsOfAllUsersModel extends ChangeNotifier {
  String uid = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  bool isCurrentUserPost = false;
  String mail = '';

  List<CatsOfAllUsers> catsOfAllUsersList = [];

  Future fetchContact() async {
    startLoading();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    this.mail = firebaseUser.email;
    endLoading();
    notifyListeners();
  }

  Future<void> sendPostReport({
    @required String reportPost,
    @required String reportUser,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('contacts').add({
        //通報した人のuserId
        'userId': FirebaseAuth.instance.currentUser.uid,
        //通報した人のメールアドレス
        'email': this.mail,
        //通報された人
        'reportUser': reportUser,
        //通報された投稿
        'reportPost': reportPost,
        //作成した日
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('投稿通報時にエラー');
      throw ('エラーが発生しました');
    }
  }

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
    //postsの中の投稿を150件しか表示させない
    final snapshots =
        FirebaseFirestore.instance.collection('posts').limit(150).snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final catsOfAllUsersList =
          docs.map((doc) => CatsOfAllUsers(doc)).toList();
      //スイッチの切り替えで自分の投稿
      if (!isCurrentUserPost) {
        catsOfAllUsersList.removeWhere(
          (currentUserList) =>
              currentUserList.userId != FirebaseAuth.instance.currentUser.uid,
        );
      }
      //ログインしている自身のuserIdまたはblockUserId内に既に自身のuidがある投稿は削除
      catsOfAllUsersList.removeWhere(
        (blockUserList) => blockUserList.blockedUserId.toString().contains(uid),
      );
      catsOfAllUsersList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.catsOfAllUsersList = catsOfAllUsersList;
      endLoading();
    });
    notifyListeners();
  }

  // お気に入りボタンを押した時の処理
  Future<void> pressedFavoriteButton({
    @required String id,
    @required String uid,
    @required bool isFavoritePhotos,
  }) async {
    bool _oldState = isFavoritePhotos;
    // お気に入りの ON/OFF を切り替える
    switchFavoriteState(
      input: _oldState,
      isFavoritePhotos: isFavoritePhotos,
    );

    // 対象をお気に入りから削除する
    if (isFavoritePhotos) {
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
    @required anotherUid,
    @required bool isLikePhotos,
    @required List<dynamic> likeUserId,
  }) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    WriteBatch _batch = _fireStore.batch();

    DocumentReference _anotherUserDoc =
        _fireStore.collection('users').doc(anotherUid);

    bool _oldState = isLikePhotos;
    // いいねの ON/OFF を切り替える
    switchLikeState(
      input: _oldState,
      isLikePhotos: isLikePhotos,
    );

    likeUserPosts(id: id, isLikePhotos: isLikePhotos);
    // 対象をいいねから削除する
    if (isLikePhotos) {
      await FirebaseFirestore.instance
          .collection('users/$uid/like_posts')
          .doc(id)
          .delete();

      _batch.update(_anotherUserDoc, {'likedCount': FieldValue.increment(-1)});

      if(likeUserId.contains(uid)){
        _batch.update(_anotherUserDoc, {'likedCount': FieldValue.increment(0)});
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

        _batch.update(_anotherUserDoc, {'likedCount': FieldValue.increment(1)});

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

    _batch.update(_myUserDoc, {'postedCount': FieldValue.increment(-1)});

    await _batch.commit();
  }

  Future<void> blockUserPosts({@required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(id).update(
        <String, FieldValue>{
          'blockedUserId': FieldValue.arrayUnion(<String>[uid]),
        },
      );
    } catch (e) {
      print('ブロックした時にエラーが発生');
      print(e);
    }
    notifyListeners();
  }

  Future<void> likeUserPosts(
      {@required String id, @required bool isLikePhotos}) async {
    if (isLikePhotos) {
      try {
        await FirebaseFirestore.instance.collection('posts').doc(id).update(
          <String, FieldValue>{
            'likeUserId': FieldValue.delete(),
          },
        );
      } catch (e) {
        print('いいね解除時にエラーが発生');
        print(e);
      }
    } else {
      try {
        await FirebaseFirestore.instance.collection('posts').doc(id).update(
          <String, FieldValue>{
            'likeUserId': FieldValue.arrayUnion(<String>[uid]),
          },
        );
      } catch (e) {
        print('いいねした時にエラーが発生');
        print(e);
      }
    }
    notifyListeners();
  }

  void switchFavoriteState({
    @required bool input,
    @required bool isFavoritePhotos,
  }) {
    isFavoritePhotos = !input;
    notifyListeners();
  }

  void switchLikeState({
    @required bool input,
    @required bool isLikePhotos,
  }) {
    isLikePhotos = !input;
    notifyListeners();
  }

  Future<void> changeCurrentUserPosts() async {
    if (isCurrentUserPost) {
      isCurrentUserPost = false;
      await fetchPostsRealTime();
    } else {
      isCurrentUserPost = true;
      await fetchPostsRealTime();
    }
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
