import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/size_extension.dart';



class ProfilePartialBuildViewModel extends BaseViewModel{
  final NavigationService _navigationService = locator<NavigationService>(); 

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

  final fontSize=new TextStyle(
    fontSize: 34.sp
  );

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


  Future<void> navigateToAddAssistantPage() async {
 await _navigationService.clearStackAndShow(Routes.addAssistantRoute);
  }
}