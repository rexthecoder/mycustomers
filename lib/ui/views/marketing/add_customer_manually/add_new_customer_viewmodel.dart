import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/app/router.dart';

class AddNewCustomerViewModel extends BaseViewModel {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String _customerName;
  String _customerPhoneNumber;



  NavigationService _navigationService = locator<NavigationService>();
  final _customerService = locator<CustomerContactService>();
  

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
  void sendMessage(){
    Customer _customer = Customer(name: name.text, phone: phoneNumber.text);
    List<Customer> _newCustomer = [_customer];

    _navigationService
        .navigateTo(Routes.quickMessages,arguments: _newCustomer);
  }


  void updateCountryCode(String value){
    _dropDownValue=value;
    notifyListeners();
  }
  Future returnHome() async {
    _customerService.addContactmarket(phoneNumber.text, name.text, dropDownValue, name.text[0], StoreRepository.currentStore.id);
    _navigationService.popUntil((route){
      if(route.settings.name == '/main'){
        return true;
      }else{
        return false;
      }
    });
  }
}