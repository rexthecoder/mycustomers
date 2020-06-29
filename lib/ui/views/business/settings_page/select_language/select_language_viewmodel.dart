import 'package:injectable/injectable.dart';
import 'package:mycustomers/ui/views/business/settings_page/settings_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SelectLanguageViewModel extends BaseViewModel{
  List langs = [
    { 'name': 'English', 'selected': true },
    { 'name': 'Francias', 'selected': false },
  ];
  var index = 0;

  void selectLang(int ind) {
    langs[index]['selected'] = !langs[index]['selected'];
    langs[ind]['selected'] = !langs[ind]['selected'];
    index = ind;
    SettingsPageViewModel().setIndex(index);
    print(index);
    notifyListeners();
  }
}