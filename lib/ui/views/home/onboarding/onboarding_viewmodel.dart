import 'dart:async';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class OnboardingViewModel extends BaseViewModel {

// Initialize view State
OnboardingViewModel() {
    init();
  }

int currentIndex = 0;
int numPages = 3;

  onChangedFunction(int index) {
    currentIndex = index;
    notifyListeners();
  }


//Init Function
init() {
 Timer.periodic(Duration(seconds: 3), (Timer timer) {
       currentIndex++;
       notifyListeners();
      //  print('Timer is: $timer, Index is: $currentIndex');  
   });
  }

  

final NavigationService _navigationService = locator<NavigationService>();
  
  Future navigateToNext() async {
    removeListener(init());
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.languageViewRoute);
  }

}
