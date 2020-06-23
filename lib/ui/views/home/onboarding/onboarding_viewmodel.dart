import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class OnboardingViewModel extends BaseViewModel {
 
 PageController pageController;
  int currentIndex = 0;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  nextFunction() {
    pageController.nextPage(duration: _kDuration, curve: _kCurve);
    notifyListeners();
  }

  previousFunction() {
    pageController.previousPage(duration: _kDuration, curve: _kCurve);
    notifyListeners();
  }

  onChangedFunction(int index) {
    currentIndex = index;
    notifyListeners();
  }


  final NavigationService _navigationService = locator<NavigationService>();

  
  Future setup() async {
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.languageViewRoute);
  }

}
