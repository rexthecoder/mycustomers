import 'dart:async';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
// Initialize view State
  OnboardingViewModel() {
    init();
  }
  bool _disposed = false;
  bool get disposed => _disposed;

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
    // Logger.w('Timer is: $timer, Index is: $currentIndex');
    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
   // print('dispose');
  }

  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToNext() async {
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.languageViewRoute);
  }
}
