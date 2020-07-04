import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MarketingHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  // dummy data
  // TODO: implement service to get frequently contacted
  List _persons = [
    {'name': 'Seyi Onifade', 'number': '09088355273'},
    {'name': 'Mark Essien', 'number': '09088355273'},
    {'name': 'Ufe Atabo', 'number': '09088355273'}
  ];

  // TODO: implement service to get notification status
  bool _notification = true;

  bool get notification => _notification;

  List get persons => _persons;

  // Function to serve as a helper for the navigation
  Future navigateToSendMessageView() async {
    await _navigationService.navigateTo(Routes.sendMessageViewRoute);
  }
}
