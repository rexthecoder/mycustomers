import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  // TODO:
  //    loading,
  //    authentication,
  //    permissions manager,

  Future setup() async {
    await locator.allReady();
    await _navigationService.replaceWith(Routes.mainViewRoute);
  }
}
