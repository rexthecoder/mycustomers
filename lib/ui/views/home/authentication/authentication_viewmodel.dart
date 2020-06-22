import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>(); 

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

  // Playing
  Future<void> init() async {
    await Future.delayed(Duration(seconds: 5));
 await _navigationService.replaceWith(Routes.nameViewRoute);
  }
}
