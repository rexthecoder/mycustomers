import 'package:stacked/stacked.dart';

class CurrencySettingsPageViewModel extends BaseViewModel {
  List<Currencies> currencies = [
    Currencies(currency: 'Naira (NGN)', index: 0),
    Currencies(currency: 'Dollar (USD)', index: 1),
    Currencies(currency: 'Indian Rubies (INR)', index: 2),
  ];

  int currentIndex = 0;

  Function currencyBoxColorChanger(model, currency) {
    currentIndex = currencies.indexOf(currency);
    return null;
  }

  ///notifyListener didn't work here sadly

}

class Currencies {
  final String currency;
  final String imagePath;
  final int index;

  Currencies({this.currency, this.imagePath, this.index});
}
