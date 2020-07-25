import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MessageHistoryViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  Customer currentCustomer;
  TextEditingController messageController =TextEditingController();
  List<String> dummyQuickText= ['Don\'t leave me', 'Happy New Year', ' Season\'s greeting', 'Happy weekend'];
  List<String> dummyQuickTextMessages = [
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend'
        'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
    'Don\'t leave meHappy New YearSeason\'s greeting Happy weekend',
  ];

  popView() {
    _navigationService.back();
  }

  init(customer){
    currentCustomer =customer;
    notifyListeners();
  }

  setText(value){
    messageController.text= value;
    notifyListeners();
  }

}