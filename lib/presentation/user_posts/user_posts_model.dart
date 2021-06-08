import 'package:catter_app/domain/cats%20_of_all_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserPostsModel extends ChangeNotifier {
  UserPostsModel({@required this.userId});
  String userId;
  String displayName;
  String profilePhotoURL;
  int postedCount;
  List<CatsOfAllUsers> catsOfAllUsersList = [];
  bool isLoading = false;

  Future<void> fetchUserPostsRealTime() async {
    startLoading();
    final snapshots =
    FirebaseFirestore.instance.collection('posts').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final catsOfAllUsersList =
      docs.map((doc) => CatsOfAllUsers(doc)).toList();
      catsOfAllUsersList.removeWhere(
            (userPosts) => userPosts.userId != userId,
      );
      catsOfAllUsersList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.catsOfAllUsersList = catsOfAllUsersList;
      endLoading();
    });
    notifyListeners();
  }

  Future<void> init() async {
    startLoading();
    DocumentSnapshot _userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc('$userId')
        .get();

    this.displayName = _userDoc.data()['displayName'];
    this.profilePhotoURL =_userDoc.data()['profilePhotoURL'];
    this.postedCount =_userDoc.data()['postedCount'];
    notifyListeners();
    endLoading();
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
