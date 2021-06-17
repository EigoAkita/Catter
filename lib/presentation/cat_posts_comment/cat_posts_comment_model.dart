import 'package:catter_app/config/ng_word.dart';
import 'package:catter_app/domain/post_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CatPostsCommentModel extends ChangeNotifier {
  CatPostsCommentModel({
    @required this.postId,
  });

  String postId;

  String uid = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  String mail = '';
  String comment = '';
  bool isCommentValid = false;
  String errorComment = '';
  List<PostComment> postCommentList = [];

  Future fetchContact() async {
    startLoading();
    final firebaseUser = FirebaseAuth.instance.currentUser;
    this.mail = firebaseUser.email;
    endLoading();
    notifyListeners();
  }

  Future<void> sendPostCommentReport({
    @required String reportComment,
    @required String reportCommentUser,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('contacts_comment').add({
        //通報した人のuserId
        'userId': uid,
        //通報した人のメールアドレス
        'email': this.mail,
        //通報されたコメントをした人
        'reportCommentUser': reportCommentUser,
        //通報されたコメント
        'reportComment': reportComment,
        //作成した日
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('コメント通報時にエラー');
      throw ('エラーが発生しました');
    }
  }

  Future<void> fetchPostComment() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance
        .collection('posts/$postId/comments')
        .get();
    final docs = snapshot.docs;
    final postCommentList = docs.map((doc) => PostComment(doc)).toList();
    this.postCommentList = postCommentList;
    endLoading();
    notifyListeners();
  }

  Future<void> fetchPostCommentsRealTime() async {
    startLoading();
    //posts/{postId}/commentsの中の投稿を150件しか表示させない
    final snapshots = FirebaseFirestore.instance
        .collection('posts/$postId/comments')
        .limit(150)
        .snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final postCommentList = docs.map((doc) => PostComment(doc)).toList();
      //ログインしている自身のuserIdまたはblockUserId内に既に自身のuidがある投稿は削除
      postCommentList.removeWhere(
        (blockCommentUserList) =>
            blockCommentUserList.blockedUserId.toString().contains(uid),
      );
      postCommentList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.postCommentList = postCommentList;
      endLoading();
    });
    notifyListeners();
  }

  Future<void> deleteMyPostComment({
    @required String id,
  }) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    WriteBatch _batch = _fireStore.batch();

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference _commentDoc = _firestore.collection('posts').doc(postId);
    DocumentReference _comment = _firestore.collection('posts').doc(postId);
    DocumentSnapshot _snap = await _comment.get();
    int _commentCount = _snap.data()['commentCount'];

    if (_commentCount > 0) {
      _batch.update(_commentDoc, {'commentCount': FieldValue.increment(-1)});
    } else {
      _batch.update(_commentDoc, {'commentCount': 0});
    }

    await FirebaseFirestore.instance
        .collection('posts/$postId/comments')
        .doc(id)
        .delete();

    await _batch.commit();
  }

  Future<void> addCommentToFirebase() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    WriteBatch _batch = _firestore.batch();

    // コメントのドキュメント ID を空のドキュメントを指定して生成する
    String _commentId =
        _firestore.collection('posts/$postId/comments').doc().id;

    // 追加するコメントのドキュメントレファレンス
    DocumentReference _myCommentDoc =
        _firestore.collection('posts/$postId/comments').doc(_commentId);

    DocumentReference _myUserDoc = _firestore.collection('users').doc(uid);
    DocumentSnapshot _snap = await _myUserDoc.get();
    String profilePhotoURL = _snap.data()['profilePhotoURL'];
    String displayName = _snap.data()['displayName'];

    DocumentReference _commentDoc = _firestore.collection('posts').doc(postId);

    // posts/{postId}/comments コレクションコメントデータを set
    _batch.set(
      _myCommentDoc,
      {
        'id': _commentId,
        'userId': uid,
        'displayName': displayName,
        'profilePhotoURL': profilePhotoURL,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
    );

    _batch.update(_commentDoc, {'commentCount': FieldValue.increment(1)});

    await _batch.commit();
    notifyListeners();
  }

  Future<void> blockUserComments({@required String id}) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts/$postId/comments')
          .doc(id)
          .update(
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

  void startLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    this.isLoading = false;
    notifyListeners();
  }

  void changePostsComment(text) {
    this.comment = text;
    if (text.length > 140) {
      this.isCommentValid = false;
      this.errorComment = '140 文字以内で入力して下さい（現在 ${text.length} 文字）。';
    } else if (ngWord.any(
      (ngWordItem) => text.contains(ngWordItem),
    )) {
      this.isCommentValid = false;
      this.errorComment = '使用出来ない文字が含まれています';
    } else {
      this.isCommentValid = true;
      this.errorComment = '';
    }
    notifyListeners();
  }
}
