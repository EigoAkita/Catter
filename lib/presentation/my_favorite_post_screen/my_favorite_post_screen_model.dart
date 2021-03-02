import 'package:catter_app/domain/my_favorite_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFavoritePostScreenModel extends ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  List<MyFavoritePostScreen> myFavoritePostScreenList = [];

  Future<void> fetchMyFavoritePost() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance.collection('users/$uid/favorite_posts').get();
    final docs = snapshot.docs;
    final myFavoritePostScreenList = docs.map((doc) => MyFavoritePostScreen(doc)).toList();
    this.myFavoritePostScreenList = myFavoritePostScreenList;
    endLoading();
    notifyListeners();
  }

  Future<void> fetchMyFavoritePostRealTime() async {
    startLoading();
    final snapshots =
    FirebaseFirestore.instance.collection('users/$uid/favorite_posts').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final myFavoritePostScreenList = docs.map((doc) => MyFavoritePostScreen(doc)).toList();
      myFavoritePostScreenList.sort((a, b) => b.favoriteAt.compareTo(a.favoriteAt));
      this.myFavoritePostScreenList = myFavoritePostScreenList;
      endLoading();
    });
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
