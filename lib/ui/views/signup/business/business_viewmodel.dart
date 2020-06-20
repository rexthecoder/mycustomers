import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusinessViewModel extends BaseViewModel{
  final NavigationService _navigationService = locator<NavigationService>(); 

void navigateBack() {
  //  await Future.delayed(Duration(seconds: 1));
  _navigationService.back();
  }

  Future<void> navigateForward() async {
  //  await Future.delayed(Duration(seconds: 1));
 await _navigationService.clearStackAndShow(Routes.mainViewRoute);
  }
}