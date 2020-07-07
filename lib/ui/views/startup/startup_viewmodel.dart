import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
 
 

  bool previewImport = false;
  // TODO:
  //    loading,
  //    authentication,
  //    permissions manager,

  Future setup() async {
    await locator.allReady();  
    await  Future.delayed(Duration(seconds: 1));
    _navigationService.replaceWith(Routes.onboardingViewRoute);
  }
}
