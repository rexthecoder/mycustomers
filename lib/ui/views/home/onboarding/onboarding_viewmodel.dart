import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class OnboardingViewModel extends BaseViewModel {
 @override


  // Timer.periodic(d                                                                      uration(seconds: 5), (Timer timer) {
  //   if (_currentPage < 2) {
  //     _currentPage++;
  //   } else {
  //     _currentPage = 0;
  //   }

  //   _pageController.animateToPage(
  //     _currentPage,
  //     duration: Duration(milliseconds: 350),
  //     curve: Curves.easeIn,
  //   );
  // });



 PageController pageController =PageController(
  initialPage: 0,
  viewportFraction: 0.8
);

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
