import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  final PageController _controller =
      PageController(initialPage: 0, keepPage: true);

  PageController get controller => _controller;

  String _username;

  String get currentUsername => _username;
  int _pageIndex;

  int get currentPageIndex => _pageIndex;

  set pageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  void initialise() {
    _username = 'wearsmute';
    _pageIndex = 0;
    notifyListeners();
  }
}
