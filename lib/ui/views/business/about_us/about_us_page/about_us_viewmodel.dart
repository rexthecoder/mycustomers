import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AboutUsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToAboutMyCustomer() async {
    await _navigationService.navigateTo(Routes.about_myCustomer);
  }

  Future navigateToPrivacyPolicy() async {
    await _navigationService.navigateTo(Routes.privacy_policy);
  }

  Future navigateToTermsAndConditions() async {
    await _navigationService.navigateTo(Routes.terms_and_conditions);
  }
}
