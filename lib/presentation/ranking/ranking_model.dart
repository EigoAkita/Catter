import 'package:catter_app/domain/ranking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RankingModel extends ChangeNotifier {
  bool isLoading = false;
  List<Ranking> rankingList = [];

  Future<void> fetchUsers() async {
    startLoading();
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    final docs = snapshot.docs;
    final rankingList = docs.map((doc) => Ranking(doc)).toList();
    this.rankingList = rankingList;
    endLoading();
    notifyListeners();
  }

  Future<void> fetchUsersRealTime() async {
    startLoading();
    final snapshots =
        FirebaseFirestore.instance.collection('users').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final rankingList = docs.map((doc) => Ranking(doc)).toList();
      rankingList.sort((a, b) => b.likedCount.compareTo(a.likedCount));
      this.rankingList = rankingList;
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
