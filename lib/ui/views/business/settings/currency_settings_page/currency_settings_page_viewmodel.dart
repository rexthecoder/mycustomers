import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';

class CurrencySettingPageViewModel extends ReactiveViewModel{
  final _bussinessSettingService = locator<BussinessSettingService>();
  int get index => _bussinessSettingService.currency;
  List get currencies => _bussinessSettingService.currencies;
  int tempIndex;

  void selectCurrency(int ind) {
    _bussinessSettingService.selectCurrency(ind);
    tempIndex = ind;
    notifyListeners();
  }

  void saveCurrencyIndex(){
    _bussinessSettingService.addCurrency(currencies[tempIndex]['country']);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bussinessSettingService];
}