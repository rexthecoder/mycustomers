import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusinessHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

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
