import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/core/services/user_services.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusinessViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final AuthService _authService = locator<AuthService>();
  

  Future<void> navigateToNext() async {
    await _navigationService.replaceWithTransition(MainView(),
        opaque: true, transition: 'cupertino', duration: Duration(seconds: 2));

  }

  updateUser(String name, String businessName) async {
    await _userService.updateUser(
      _authService.currentUser.id,
      updateData: {
        'first_name': name,
        'last_name': businessName,
      },
      );
    navigateToNext();
  }

bool btnColor = true;

   void activeBtn() {
    btnColor = !btnColor;
    notifyListeners();
  }

}
