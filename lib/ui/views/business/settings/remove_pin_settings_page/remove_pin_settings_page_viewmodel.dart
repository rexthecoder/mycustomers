import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';


class RemovePinSettingsPageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final PasswordManagerService _passwordManagerService = locator<PasswordManagerService>();


  void onEnterPinCompleted(String value){
    String passFrmDb=_passwordManagerService.getPassword().toString(); // get the password stored in the db
    int newPassFrmDb =int.parse(passFrmDb); // cast it into an integer
    int confirmPin = int.parse(value);  // cast the password entered
    int check = newPassFrmDb.compareTo(confirmPin); // compare they are equal
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
