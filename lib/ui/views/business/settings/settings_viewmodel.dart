import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsHomePageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>(); 


  String _pageTitle='Settings';
  String get pageTitle => _pageTitle;

  String _language ='Change Language';
  String _currency ='Change Currency';
  String _appLock ='App Lock';
  String _userLanguagePref='English';// Implement a list that contains all the Languages
  String _currencyType='Dollars';  // Implement a list that contains all the currencies

  String get languageTitle => _language;
  String get currencyHeading => _currency;
  String get appLockHeading => _appLock;
  String get userLanguage => _userLanguagePref;
  String get currencyType => _currencyType;

  String _notification = 'Receive Notification';
  String _newsLetter = 'Receive Newsletters';
  String _specialOffers = 'Receive Special Offers';
  String _updates = 'Receive Updates';

  String get notification =>_notification;
  String get newsletter =>_newsLetter;
  String get specialOffers =>_specialOffers;
  String get updates => _updates;

  bool _swichValue=false;
  bool get switchValue => _swichValue;

  final prefTextStyle = TextStyle(
    fontSize: 18.sp,
    color: Color(0xff595959)

  );

  final mainTextStyle= TextStyle(
    fontSize: 36.sp,
    color:ThemeColors.black,
    letterSpacing: -0.02
  );

  String get btnText => 'Save';

  void onChanged( bool value){
    _swichValue=value;
    notifyListeners();
  }

  Future<void> navigateToChangeLanguagePage() async {
  await _navigationService.clearStackAndShow(Routes.changeLanguagePref);
  }

  
}
