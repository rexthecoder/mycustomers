
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';

class BusinessHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final _storeRepository = locator<StoreRepository>();

  String get profileCardTitle => _storeRepository?.currentStore?.name ?? 'None';

  String get profileCardSubtitle =>
      _storeRepository?.currentStore?.address ?? '---';

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
