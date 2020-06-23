import 'package:stacked/stacked.dart';


class ProfilePartialBuildViewModel extends BaseViewModel{
  String _userName;
  String _businessName;
  String _userPhoneNumber;
  

  String _dropDownValue='+234';
  List<String> _countryCodes=['+234','+254','+250','+230'];

  List<String> get countryCode=>_countryCodes;
  String get dropDownValue=> _dropDownValue;

  String get userName => _userName;
  String get businessName => _businessName;
  String get userPhoneNumber => _userPhoneNumber;

  void updateUserName(String name){
     _userName=name;
    notifyListeners();

}

void updateBusinessName(String businessName){
  _businessName=businessName;
  notifyListeners();

}

void updateUserPhoneNumber(String phoneNumber){
  _userPhoneNumber=phoneNumber;
  notifyListeners();
}

void updateCountryCode(String value){
    _dropDownValue=value;
    notifyListeners();
  }

}