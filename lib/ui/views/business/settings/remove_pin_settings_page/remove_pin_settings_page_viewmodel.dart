import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RemovePinSettingsPageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();

  void onEnterPinCompleted(String value) {
    // TODO Get Pin from db
    // TODO Check if pin is correct
//    if (check == 0) {
//      // TODO Save to DB
//      // TODO Display success
      _navigationService.popRepeated(1);
//    } else {
//      // TODO process error
//    }


  }


}
