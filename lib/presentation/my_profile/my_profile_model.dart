import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfileModel extends ChangeNotifier {
  String displayName;
  String profilePhotoURL;
  int likedCount;
  int postedCount;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init() async {
    startLoading();
    DocumentSnapshot _userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc('${this._auth.currentUser.uid}')
        .get();

    this.displayName = _userDoc.data()['displayName'];
    this.profilePhotoURL =_userDoc.data()['profilePhotoURL'];
    this.likedCount =_userDoc.data()['likedCount'];
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
