import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/ui/views/home/signup/signup_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String phoneNumber;
  bool obscureText = false;
  bool btnColor = true;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void togglePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void activeBtn() {
    btnColor = !btnColor;
    notifyListeners();
  }


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

  void init() {}
}
