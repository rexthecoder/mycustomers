import 'dart:async';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class GetStartedViewModel extends BaseViewModel {
 
 //Page controller Index
  int currentIndex = 0;
  int numPages = 3;

  onChangedFunction(int index) {
    currentIndex = index;
    notifyListeners();
  }

// Navigation
  final NavigationService _navigationService = locator<NavigationService>();

   Future navigateToLogin() async {
    // await Future.delayed(Duration(seconds: 5));
 await _navigationService.replaceWith(Routes.signinViewRoute);
  }

  Future navigateToNextScreen() async {
    // await Future.value();
    await _navigationService.clearStackAndShow(Routes.onboardingViewRoute);
  }

}
