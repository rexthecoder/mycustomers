import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  String phoneNumber;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {}

  Future onInputChange() async {}

  final NavigationService _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();


  // Navigation
  Future navigateToLogin() async {
    // await Future.delayed(Duration(seconds: 5));
    await _navigationService.navigateTo(Routes.signinViewRoute);
  }

  Future navigateToNextScreen() async {
    // await Future.delayed(Duration(seconds: 5));
    await _navigationService.clearStackAndShow(Routes.verificationViewRoute);
  }

  Future<void> signUp(String phoneNumber, String password) async {
    setBusy(true);
    try {
      await _authService.signUpWithPhoneNumber(phoneNumber, password);
      unawaited(navigateToNextScreen());
    } on AuthException catch (e) {
      Logger.e(e.message);
      setBusy(false);
    }
}
}