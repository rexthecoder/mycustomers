import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class CreateReceiptViewModel extends BaseViewModel {

  final pageController = new PageController(initialPage: 0);
  String _currency = 'Select Currency';
  String get currency => _currency;

  List<String> _currencies = [
    //TODO: Add Dropdown Items
    'NGN',
    'USD',
    'RUP'
  ];

  List<String> get currencies => _currencies;

  void setItem(String currency){
    _currency = currency;
    notifyListeners();
}

  String _category = 'Category';
  String get category => _category;

  List<String> _categories = [
    //TODO: Add Dropdown Items
    'first Category',
    'second Category',
    'third Category'
  ];

  List<String> get categories => _categories;

  void setCategory(String category){
    _category = category;
    notifyListeners();
  }
  validateFields(value) => value.isEmpty ? 'Please fill' : null;
}