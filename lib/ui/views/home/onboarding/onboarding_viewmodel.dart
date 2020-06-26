import 'dart:async';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class OnboardingViewModel extends BaseViewModel {

  OnboardingViewModel() {
    init();
  }

  // PageController pageController = PageController(initialPage: 0);

int currentIndex = 0;
int numPages = 3;

  // static const _kDuration = const Duration(milliseconds: 300);
  // static const _kCurve = Curves.ease;

  // nextFunction() {
  //   pageController.nextPage(duration: _kDuration, curve: _kCurve);
  // }

  // previousFunction() {
  //   pageController.previousPage(duration: _kDuration, curve: _kCurve);
  // }


  onChangedFunction(int index) {
    currentIndex = index;
    notifyListeners();
  }




  void init() {
 Timer.periodic(Duration(seconds: 3), (Timer timer) {
       currentIndex++;
       notifyListeners();
       print('Timer is: $timer, Index is: $currentIndex');
   });
  }

  

final NavigationService _navigationService = locator<NavigationService>();
  
  Future navigateToNext() async {
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.languageViewRoute);
  }

}
