import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';

class LanguagePageViewModel extends ReactiveViewModel{  
  final _bussinessSettingService = locator<BussinessSettingService>();
  int get index => _bussinessSettingService.language;
  List get langs => _bussinessSettingService.langs;

  int tempIndex;

  void selectLang(int ind) {
    _bussinessSettingService.selectLangs(ind);
    tempIndex = ind;
    //SettingsPageViewModel().setIndex(index);
    print(index);
    notifyListeners();
  }

  void saveLang(){
    _bussinessSettingService.setLanguageIndex(tempIndex);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bussinessSettingService];
}