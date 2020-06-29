import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

class SelectCurrencyViewModel extends BaseViewModel{
  List currencies = [
    { 'name': 'Naira(NGN)', 'selected': true },
    { 'name': 'Dollar(USD)', 'selected': false },
    { 'name': 'Indian Rubies(INR)', 'selected': false },
  ];
  int index = 0;

  void selectLang(int ind) {
    currencies[index]['selected'] = !currencies[index]['selected'];
    currencies[ind]['selected'] = !currencies[ind]['selected'];
    index = ind;
    notifyListeners();
  }
}