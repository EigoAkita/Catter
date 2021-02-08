import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  int currentIndex = 0;

  Future onTapTapped(int index) async {
    currentIndex = index;
    notifyListeners();
  }
}