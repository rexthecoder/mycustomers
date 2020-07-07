import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';


class RemovePinSettingsPageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final PasswordManagerService _passwordManagerService = locator<PasswordManagerService>();


  void onEnterPinCompleted(String value){
    final passFrmDb=_passwordManagerService.getPassword();
    int newPassFrmDb =int.parse(passFrmDb.toString());
    int confirmPin = int.parse(value);
    int check = newPassFrmDb.compareTo(confirmPin);
    if(check == 0){
       _passwordManagerService.deleteSetPin();
       _passwordManagerService.showPinRemoveConfirmationMessage();
       _navigationService.popRepeated(1);
    }
    else{
      _passwordManagerService.showRemoveErrorMessage();
    }

  }


}
