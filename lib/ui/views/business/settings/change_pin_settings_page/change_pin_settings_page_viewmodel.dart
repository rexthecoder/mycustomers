import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/hive/password_manager/password_manager_model_h.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class ChangePinSettingsPageViewModel extends BaseViewModel {
   final PasswordManagerService _passwordManagerService =
      locator<PasswordManagerService>();
   static PasswordManager passManager=PasswordManager(null);
   String password = passManager.userPassword;
  int _pin = 0;
  int _index = 0;

  int get index => _index;

  final NavigationService _navigationService = locator<NavigationService>();


  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void onCreatePinCompleted(String value) {
    _pin = int.parse(value);
    changeTab(1);
  }

  void onConfirmPinCompleted (String value){
    int confirmPin = int.parse(value);
    int check = _pin.compareTo(confirmPin);
    String newValue = confirmPin.toString();
    if (check == 0) {
      _passwordManagerService.saveSetPin(newValue);
      _passwordManagerService.showPinSetConfirmationMessage();
      _navigationService.popRepeated(1);
    } 
    else {
      _passwordManagerService.showErrorMessage();
    }
  }

 



}

