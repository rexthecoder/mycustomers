import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String phoneNumber;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {}

  Future onInputChange() async {}

  // Navigate
  Future navigateToNextScreen() async {
    await _navigationService.clearStackAndShow(Routes.verificationViewRoute);
  }

  void init() {}
}
