import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StuffModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String _upperBoxText = 'Happy New Year!';
  String get upperBoxText => _upperBoxText;

  String lowerBoxText = 'Happy New Year \n Best wishes from me';

  List<String> templateList = [
    'Happy New Year \n Best wishes from me',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Reloaded 3 of 692 libraries in 1,777ms.',
    'Reloaded 3 of 692 libraries in 1,777ms.'
  ];

  int numberOfSelectedCustomers = 3;

  bool checkBoxValue = true;
  checkBoxFunction(bool val) {
    checkBoxValue = val;
    val = !val;
  }

  int currentIndex = 0;
  onTap(template) {
    currentIndex = templateList.indexOf(template);
  }

  // Function to serve as a helper for the navigation
  Future navigateTo() async {
    await _navigationService.navigateTo(Routes.marketingHomepageView);
  }

  Future navigateToQuickMessage() async {
    await _navigationService.navigateTo(Routes.quickMessageView);
  }
}
