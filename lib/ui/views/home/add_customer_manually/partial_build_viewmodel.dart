import 'package:stacked/stacked.dart';


// partial_builds_viewmodel.dart


class PartialBuildsViewModel extends BaseViewModel {
  

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