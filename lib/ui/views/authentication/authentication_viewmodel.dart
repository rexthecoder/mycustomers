import 'package:stacked/stacked.dart';

class AuthenticationViewModel extends BaseViewModel {
  String _dropdownValue = '+234';

  String get dropdownValue => _dropdownValue;

  List<String> _dropdownItems = ['+234', '+229', '+256', '+209'];

  List<String> get dropdownItems => _dropdownItems;

  void setDropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

  String _phoneNumber;

  String get phoneNumber => _phoneNumber;

  void setPhoneNumber(String value) {
    _phoneNumber = value;
  }
}
