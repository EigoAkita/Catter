import 'package:flutter/material.dart';

class SettingModel extends ChangeNotifier {
  bool isLoading = false;

  void startLoading() {
    this.isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    this.isLoading = false;
    notifyListeners();
  }
}
