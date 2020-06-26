import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusinessViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> navigateToNext() async {
    await Future.delayed(Duration(seconds: 2));
    await _navigationService.replaceWith(Routes.mainViewRoute);
  }
}
