import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
  bool validateNumber(){
    return phoneNumber.text.length ==11?? false;
  }
  bool validateName(){
    return name.text.isNotEmpty?? false;
  }

  void updateCountryCode(String value){
    _dropDownValue=value;
    notifyListeners();
  }
  NavigationService _navigationService = locator<NavigationService>();
  returnCustomers() {
    Customer _customer = Customer(name: name.text, phone: phoneNumber.text);
    List<Customer> _newCustomer = [_customer];
    _navigationService.back(result: _newCustomer);

//    searchedCustomer.clear();

  }
}