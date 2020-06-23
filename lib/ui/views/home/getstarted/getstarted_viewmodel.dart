import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class GetStartedViewModel extends BaseViewModel {
 @override

  PageController pageController = PageController(
  initialPage: 0,
  viewportFraction: 1.0, 
);

  int currentIndex = 0;
  int numPages = 3;

  onChangedFunction(int index) {
    currentIndex = index;
    notifyListeners();
  }

  final NavigationService _navigationService = locator<NavigationService>();

  
  Future navigateToNextScreen() async {
    // await Future.value();
    await _navigationService.clearStackAndShow(Routes.onboardingViewRoute);
  }

}
