import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/permissions.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  Permissions _permission =  locator<Permissions>();

  bool previewImport = false;

  // TODO:
  //    loading,
  //    authentication,
  //    permissions manager,

  Future setup() async {
    await locator.allReady();
    final bool isPermitted =
        await _permission.getContactsPermission();
    if (isPermitted && previewImport) await _navigationService.replaceWith(Routes.importCustomerViewRoute);
    else await _navigationService.replaceWith(Routes.getstartedViewRoute);
  }
}
