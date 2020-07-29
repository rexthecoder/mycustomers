import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/ui/views/home/sigin/signin_view.dart';
import 'package:mycustomers/ui/views/home/signup/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  //Page controller Index
  int currentIndex = 0;
  final pageController = new PageController(initialPage: 0);
  Timer _animationTimer;

  int _animeTimerSecs = 5;
  int _pageAnimeSecs = 350;

  int get animeSecs => _animeTimerSecs;
  int get pageAnimeSecs => _pageAnimeSecs;

  void changePage() {
    currentIndex < 3 ? currentIndex++ : currentIndex = 0;

    pageController.animateToPage(
      currentIndex,
      duration: Duration(milliseconds: pageAnimeSecs),
      curve: Curves.easeIn,
    );
  }

  //Init State
  void initState() {
    restartTimer(0);
    notifyListeners();
  }

  void restartTimer(int index) {
    currentIndex = index;
    _animationTimer?.cancel();
    _animationTimer = Timer(Duration(seconds: animeSecs), changePage);
  }


  // Navigation
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSignIn() async {
    await _navigationService.replaceWithTransition(
      SignInView(),
      opaque: false,
      popGesture: true,
      transition: 'rightToLeftWithFade',
      duration: Duration(milliseconds: 100),
    );
  }

  Future navigateToSignUp() async {
    await _navigationService.replaceWithTransition(
      SignUpView(),
      opaque: false,
      popGesture: true,
      transition: 'rightToLeftWithFade',
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    _animationTimer.cancel();
    super.dispose();
  }
}
