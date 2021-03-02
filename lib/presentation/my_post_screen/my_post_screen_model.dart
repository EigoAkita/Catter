import 'package:catter_app/domain/my_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPostScreenModel extends ChangeNotifier {
  final uid = FirebaseAuth.instance.currentUser.uid;
  bool isLoading = false;
  List<MyPostScreen> myPostScreenList = [];

  Future<void> fetchMyPost() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance.collection('posts').get();
    final docs = snapshot.docs;
    final myPostScreenList = docs.map((doc) => MyPostScreen(doc)).toList();
    this.myPostScreenList = myPostScreenList;
    endLoading();
    notifyListeners();
  }

  Future<void> fetchMyPostRealTime() async {
    startLoading();
    final snapshots =
        FirebaseFirestore.instance.collection('posts').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final myPostScreenList = docs.map((doc) => MyPostScreen(doc)).toList();
      myPostScreenList.retainWhere((value) => value.uid == uid);
      myPostScreenList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.myPostScreenList = myPostScreenList;
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
