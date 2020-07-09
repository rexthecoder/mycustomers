import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppLockSettingsPageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  bool isPinSet=false;

  Future navigateToChangePinPage() async {
    await _navigationService.navigateTo(Routes.changePinSettingsViewRoute);
  }

  Future navigateToRemovePinPage() async {
    await _navigationService.navigateTo(Routes.removePinSettingsViewRoute);
  }

}
