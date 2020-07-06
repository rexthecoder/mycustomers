import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/mixins/validators.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/views/home/signup/signup_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';

class SignInViewModel extends BaseViewModel with Validators {
  final NavigationService _navigationService = locator<NavigationService>();

  String phoneNumber;
  bool obscureText = true;
  bool btnColor = true;

  // String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  // void togglePassword() {
  //   obscureText = !obscureText;
  //   notifyListeners();
  // }

  // void activeBtn() {
  //   btnColor = !btnColor;
  //   notifyListeners();
  // }


  void getPhoneNumber(String phoneNumber) async {}

  Future onInputChange() async {}

  // Navigate
  Future navigateToNextScreen() async {
    await _navigationService.replaceWithTransition(MainView(),
        opaque: true, transition: 'rotate', duration: Duration(seconds: 2));
  }

  Future navigateToSignup() async {
    await _navigationService.replaceWithTransition(SignUpView(),
        opaque: true, transition: 'righttoleftwithfade', duration: Duration(seconds: 1));
  }

  final _authService = locator<AuthService>();

  Future<void> signIn(String phoneNumber, String password) async {
    setBusy(true);
    try {
      await _authService.signInWithPhoneNumber(phoneNumber, password);
      showToastCustom(message: 'You have signed in successfully', success: true,);
      unawaited(navigateToNextScreen());
      // navigateToNextScreen();
    } on AuthException catch (e) {
      showToastCustom(message: e.message,);
      Logger.e(e.message);
    } catch (e, s) {
      Logger.e('Unknown Error', e: e, s: s);
      showToastCustom(message: 'An error occured while signing up',);
    }
    setBusy(false);
  }

  void init() {}
}
