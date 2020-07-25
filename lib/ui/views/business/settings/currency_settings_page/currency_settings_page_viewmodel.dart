import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';

class CurrencySettingPageViewModel extends ReactiveViewModel{
  final _bussinessSettingService = locator<BussinessSettingService>();
  final LogsLocalDataSourceImpl _logService = locator<LogsLocalDataSourceImpl>();
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  Store get currentStore => StoreRepository.currentStore;
  int get index => _bussinessSettingService.currency;
  List get currencies => _bussinessSettingService.currencies;
  int tempIndex;
  CountryCurrency get currency => _bussinessSettingService.curren;
  CountryCurrency get oldcurrency => _bussinessSettingService.oldcurren;

  void selectCurrency(int ind) {
    _bussinessSettingService.selectCurrency(ind);
    tempIndex = ind;
    notifyListeners();
  }

  void saveCurrencyIndex() async{
    await _bussinessSettingService.addCurrency(currencies[tempIndex]['country']);
    _transactionService.updateamount(oldcurrency, currency, currentStore.id);
    _logService.getValues(null, DateTime.now(), 'curr-change', currencies[tempIndex]['name'], false);
  }

  void resetCurrency(){
    _bussinessSettingService.selectCurrency(index);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bussinessSettingService];
}