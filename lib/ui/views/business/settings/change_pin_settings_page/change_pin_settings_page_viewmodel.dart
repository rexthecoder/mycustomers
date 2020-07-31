import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/localStorage_services.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePinSettingsPageViewModel extends BaseViewModel {
  final PasswordManagerService _passwordManagerService =
      locator<PasswordManagerService>();
  static final _localStorageServices = locator<LocalStorageService>();
  String userPin = _localStorageServices.userPin;

  String _pin = '';
  int _index = 0;

  int get index => _index;

  final NavigationService _navigationService = locator<NavigationService>();

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void onCreatePinCompleted(String value, int tabIndex) {
    _pin = value;
    changeTab(tabIndex);
  }

  void onConfirmPinCompleted(
      String value, TextEditingController textEditingController) async {
    // Parse the password value , compare the value to the set Pin value,
    // String back the value to be saved
    var confirmPin = value;
    int check = compareValue(_pin, confirmPin);
    String newValue = confirmPin;

    if (check == 0) {
      await _passwordManagerService.saveSetPin(newValue);
      setPin(true);
      _passwordManagerService.showPinSetConfirmationMessage();
      _navigationService.popRepeated(1);
    } else if (check < 0 || check > 0) {
      _passwordManagerService.showUnmatchedPinErrorMessage();
      clearValueIfPinsDoNotMatch(textEditingController);
    } else {
      _passwordManagerService.showErrorMessage();
    }
  }

  void setPin(bool value) {
    _passwordManagerService.setPin(value);
  }

  void onOldPinCompleted(String value, int tabIndex) async {
    String passFrmDb = await _passwordManagerService
        .getPassword(); // get the password stored in the db
    int check = compareValue(passFrmDb, value);

    if (check == 0) {
      changeTab(tabIndex);
    } else {
      _passwordManagerService.showUnmatchedPinErrorMessage();
      _navigationService.popRepeated(1);
    }
  }

  int compareValue(String firstPin, String secondPin) {
    return firstPin.compareTo(secondPin);
  }

  String stringNewValue(int compareValue) {
    return compareValue.toString();
  }

// int parsePasswordValue(String password){
//   return int.parse(password);
// }

  void clearValueIfPinsDoNotMatch(TextEditingController textEditingController) {
    textEditingController.clear();
  }
}
