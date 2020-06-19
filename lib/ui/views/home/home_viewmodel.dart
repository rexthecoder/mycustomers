import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
class HomeViewModel extends BaseViewModel {
   final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.addcustomerRoute);
  }
}

class HomeViewModel extends BaseViewModel {
  String _title = 'Home View';
  String get title => _title;

  final double _amount = 100.86;
  double get amount => _amount;

  void btnViewDetails() {
    print('hello');
  }
}

