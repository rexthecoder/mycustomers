import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

class AddNewCustomerViewModel extends BaseViewModel {
  String _title='Add Customer';
  String _subTitle='Customer Details';

  String get title => _title;
  String get subTitle =>_subTitle;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String _customerName;
  String _customerPhoneNumber;
  

  

  String _dropDownValue='+234';

  List<String> _countryCodes=['+234','+254','+250','+230'];

  String get customerName => _customerName;
  String get customerPhoneNumber => _customerPhoneNumber;

  

  List<String> get countryCode=>_countryCodes;
  String get dropDownValue=> _dropDownValue;

  

  void updateName(String name){
       _customerName=name;
       notifyListeners();
  }

  void updateContact(String phoneNumber){
    _customerPhoneNumber=phoneNumber;
    notifyListeners();

  }

  void updateCountryCode(String value){
    _dropDownValue=value;
    notifyListeners();
  }
 
}