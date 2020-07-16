import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class BussinessSettingService with ReactiveServiceMixin{
  RxValue<int> _currency = RxValue<int>(initial: 0);
  RxValue<int> _language = RxValue<int>(initial: 0);

  RxValue<int> _tempcurrency = RxValue<int>(initial: 0);
  RxValue<int> _templanguage = RxValue<int>(initial: 0);
  List langs = [
    { 'name': 'English', 'selected': true },
    { 'name': 'Francias', 'selected': false },
  ];
  List currencies = [
    { 'name': 'Naira(NGN)', 'selected': true },
    { 'name': 'Dollar(USD)', 'selected': false },
    { 'name': 'Indian Rubies(INR)', 'selected': false },
  ];

  int get currency => _currency.value;
  int get language => _language.value;

  int get tempcurrency => _tempcurrency.value;
  int get templanguage => _templanguage.value;

  BussinessSettingService(){
    listenToReactiveValues([_currency, _language, langs, currencies]);
  }

  void selectLangs(int ind){
    langs[templanguage]['selected'] = !langs[templanguage]['selected'];
    langs[ind]['selected'] = !langs[ind]['selected'];
    _templanguage.value = ind;
  }

  void selectCurrency(int ind) {
    currencies[tempcurrency]['selected'] = !currencies[tempcurrency]['selected'];
    currencies[ind]['selected'] = !currencies[ind]['selected'];
    _tempcurrency.value = ind;
  }

  void setCurrencyIndex(int ind){
    _currency.value = ind;
  }

  void setLanguageIndex(int ind){
    _language.value = ind;
  }
}