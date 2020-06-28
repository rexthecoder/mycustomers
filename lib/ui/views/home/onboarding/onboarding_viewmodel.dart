import 'dart:async';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class OnboardingViewModel extends BaseViewModel {

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


// @mustCallSuper
//  void init() {
// Timer.periodic(Duration(seconds: 5), (Timer timer) {
//     if (currentIndex < 2) {
//       currentIndex++;
//     } else {
//       currentIndex = 0;
//     }

//     pageController.animateToPage(
//       currentIndex,
//       duration: Duration(milliseconds: 350),
//       curve: Curves.easeIn,
//     );
//   });
//  }

  

final NavigationService _navigationService = locator<NavigationService>();
  
  Future navigateToNext() async {
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.languageViewRoute);
  }

}
