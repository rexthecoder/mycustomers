import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class EnterPinViewModel extends BaseViewModel {
   final PasswordManagerService _passwordManagerService =locator<PasswordManagerService>();

  final NavigationService _navigationService = locator<NavigationService>();



 Future<bool> onOldPinCompleted(String value) async{
   String passFrmDb= await _passwordManagerService.getPassword(); // get the password stored in the db
   bool check = passFrmDb == value;

   if(check){
     _navigationService.back();
   } else {
     _passwordManagerService.showUnmatchedPinErrorMessage();
   }
   return check;
 }


 void clearValueIfPinsDoNotMatch(TextEditingController textEditingController){
   textEditingController.clear();

    }

}


