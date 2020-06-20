import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NameViewModel extends BaseViewModel{
  final NavigationService _navigationService = locator<NavigationService>(); 

  Future<void> navigateNext() async {
//    await Future.delayed(Duration(seconds: 1));
 await _navigationService.navigateTo(Routes.businessViewRoute);
  }
}