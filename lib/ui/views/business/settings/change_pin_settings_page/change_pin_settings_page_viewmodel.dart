import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePinSettingsPageViewModel extends BaseViewModel {
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

  void onConfirmPinCompleted(String value) {
    int confirmPin = int.parse(value);
    int check = _pin.compareTo(confirmPin);
    if (check == 0) {
      // TODO Save to DB
      // TODO Display success
      _navigationService.popRepeated(1);
    } else {
      // TODO process error
    }
  }
}
