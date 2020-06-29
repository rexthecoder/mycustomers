import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  String phoneNumber;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {}

  Future onInputChange() async {}

  final NavigationService _navigationService = locator<NavigationService>();

  // Navigation
  Future navigateToLogin() async {
    // await Future.delayed(Duration(seconds: 5));
    await _navigationService.navigateTo(Routes.signinViewRoute);
  }

  Future navigateToNextScreen() async {
    // await Future.delayed(Duration(seconds: 5));
    await _navigationService.clearStackAndShow(Routes.verificationViewRoute);
  }
}
