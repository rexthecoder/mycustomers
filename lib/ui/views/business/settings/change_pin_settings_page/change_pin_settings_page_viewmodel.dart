import 'dart:math';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';  


class ChangePinSettingsPageViewModel extends BaseViewModel {
  int _pin = 0;
  int _index = 0;

  int get index => _index;

  final NavigationService _navigationService = locator<NavigationService>();

  final pinStorage = new FlutterSecureStorage();

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

  void onCreatePinCompleted(String value) {
    _pin = int.parse(value);
    changeTab(1);
  }

  void onConfirmPinCompleted (String value)  async{
    int confirmPin = int.parse(value);
    int check = _pin.compareTo(confirmPin);
    if (check == 0) {
      writeToStorageSecurity(check);
      showPinSetConfirmationMessage();
       _navigationService.popRepeated(1);
    } 
    else {
      showErrorMessage();
    }
  }

  // a function to genrate random keys for the pin entered by users
  String _randomValue() {
    final rand = Random();
    final codeUnits = List.generate(20, (index) {
      return rand.nextInt(26) + 65;
    });

    return String.fromCharCodes(codeUnits);
  }

//This function display a success message upon completion of setting pin
  void showPinSetConfirmationMessage(){
    FlutterToast.showToast(
      msg: 'Pin was set Successfully',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: BrandColors.yellow,
      textColor: ThemeColors.background,
      gravity: ToastGravity.CENTER

      );
  }

//add the pin to the storage security
  void writeToStorageSecurity(int value) async{
    String newValue=value.toString(); // Convert the value to a string
    String key = _randomValue(); // generate a random key value
    await pinStorage.write(key:key, value:newValue); // store the value
  }


//shows an error message when the pin hasn't been set.
  void showErrorMessage(){
    FlutterToast.showToast(
      msg: 'An error occurred while setting pin',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: BrandColors.secondary,
      textColor: ThemeColors.background,
      gravity: ToastGravity.CENTER
      );
  }
}

