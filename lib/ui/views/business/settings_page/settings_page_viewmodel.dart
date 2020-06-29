import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsPageViewModel extends BaseViewModel{
  bool _notification = true;
  bool _newsletter = false;
  bool _special = false;
  bool _update = true;
  int index;

  final NavigationService _navigationService = locator<NavigationService>();

  bool get notification => _notification;
  bool get newsletter => _newsletter;
  bool get special => _special;
  bool get update => _update;

  void setNotification() {
    _notification = !_notification;
    notifyListeners();
  }
  void setNewsletter() {
    _newsletter = !_newsletter;
    notifyListeners();
  }
  void setSpecial() {
    _special = !_special;
    notifyListeners();
  }
  void setUpdate() {
    _update = !_update;
    notifyListeners();
  }
  void setIndex(int ind){
    index = ind;
    print(index);
    notifyListeners();
  }
  Future navigateToCurrency() async {
    await _navigationService.navigateTo(Routes.currencySettingsViewRoute);
  }
  Future navigateToAppLock() async {
    await _navigationService.navigateTo(Routes.appLockSettingsViewRoute);
  }
}