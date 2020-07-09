import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QuickMessageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // Function to serve as a helper for the navigation
  Future navigateTo() async {
    // await _navigationService.navigateTo(Routes.sendAMessageView);
  }

  Future navigateToMessageView() async {
    // await _navigationService.navigateTo(Routes.messageView);
  }
}
