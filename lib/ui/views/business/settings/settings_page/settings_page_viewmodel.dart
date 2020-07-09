import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';

class SettingsPageViewModel extends ReactiveViewModel{
  bool _notification = true;
  bool _newsletter = false;
  bool _special = false;
  bool _update = true;
  int index;

  final NavigationService _navigationService = locator<NavigationService>();
  final _bussinessSettingService = locator<BussinessSettingService>();

  bool get notification => _notification;
  bool get newsletter => _newsletter;
  bool get special => _special;
  bool get update => _update;
  int get langIndex => _bussinessSettingService.language;
  int get currIndex => _bussinessSettingService.currency;
  List get langs => _bussinessSettingService.langs;
  List get currs => _bussinessSettingService.currencies;



  void setNotification() {
    _notification = !_notification;
    notifyListeners();
  }
  void setNewsletter() {
    _newsletter = !_newsletter;
    notifyListeners();
  }
  void setSpecial() {
    _special = !_special;
    notifyListeners();
  }
  void setUpdate() {
    _update = !_update;
    notifyListeners();
  }
  void setIndex(int ind){
    index = ind;
    print(index);
    notifyListeners();
  }
  Future navigateToCurrency() async {
    await _navigationService.navigateTo(Routes.currencySettingsViewRoute);
  }
  Future navigateToAppLock() async {
    await _navigationService.navigateTo(Routes.appLockSettingsViewRoute);
  }

  Future navigateToLanguageSettings() async {
    await _navigationService.navigateTo(Routes.languageSettingsViewRoute);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bussinessSettingService];
}