import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BusinessViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> navigateToNext() async {
    await _navigationService.replaceWithTransition(MainView(),
        opaque: true, transition: 'cupertino', duration: Duration(seconds: 2));

  }

bool btnColor = true;

   void activeBtn() {
    btnColor = !btnColor;
    notifyListeners();
  }

}
