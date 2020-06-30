import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/enums/drawer_status.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusinessHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  bool profileA = false;
  bool businessCardA = false;
  bool supportA = false;
  bool settingsA = false;

  void setActive(Active active) {
    switch (active) {
      case Active.profile:
        profileA = true;
        businessCardA = false;
        supportA = false;
        settingsA = false;
        notifyListeners();
        break;
      case Active.businessCard:
        profileA = false;
        businessCardA = true;
        supportA = false;
        settingsA = false;
        notifyListeners();
        break;
      case Active.support:
        profileA = false;
        businessCardA = false;
        supportA = true;
        settingsA = false;
        notifyListeners();
        break;
      case Active.settings:
        profileA = false;
        businessCardA = false;
        supportA = false;
        settingsA = true;
        notifyListeners();
        break;
    }
  }

  void closeDrawer() {
    _navigationService.navigateTo(Routes.mainViewRoute);
  }

  Future navigateToProfilePage() async {
    await _navigationService.navigateTo(Routes.profileViewRoute);
  }

  Future navigateToBusinessCardPage() async {
    await _navigationService.navigateTo(Routes.businessCardRoute);
  }

  Future navigateToSupportPage() async {
    await _navigationService.navigateTo(Routes.supportViewRoute);
  }

  Future navigateToSettingsPage() async {
    await _navigationService.navigateTo(Routes.bussinessSettingsPage);
  }
}
