import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class AddCustomerViewModel extends BaseViewModel {
  final String btnText1 = "Add from Contact Book";
  final String btnText2 = "Add Manually";

// Setting up a pop navigation
  final NavigationService _navigationService = locator<NavigationService>();

// Function to serve as a helper for the navigation
  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }
}
