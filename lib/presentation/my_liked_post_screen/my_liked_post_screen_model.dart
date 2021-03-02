import 'package:catter_app/domain/my_liked_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLikedPostScreenModel extends ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  List<MyLikedPostScreen> myLikedPostScreenList = [];

  Future<void> fetchMyLikedPost() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance.collection('users/$uid/like_posts').get();
    final docs = snapshot.docs;
    final myLikedPostScreenList = docs.map((doc) => MyLikedPostScreen(doc)).toList();
    this.myLikedPostScreenList = myLikedPostScreenList;
    endLoading();
    notifyListeners();
  }

  Future<void> fetchMyLikedPostRealTime() async {
    startLoading();
    final snapshots =
    FirebaseFirestore.instance.collection('users/$uid/like_posts').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final myLikedPostScreenList = docs.map((doc) => MyLikedPostScreen(doc)).toList();
      myLikedPostScreenList.sort((a, b) => b.likedAt.compareTo(a.likedAt));
      this.myLikedPostScreenList = myLikedPostScreenList;
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
