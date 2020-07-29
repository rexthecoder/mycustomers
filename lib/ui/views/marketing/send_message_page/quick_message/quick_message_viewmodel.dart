import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';

class QuickMessageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  MessageArgument argument;

  // Function to serve as a helper for the navigation
  Future navigateTo() async {
    // await _navigationService.navigateTo(Routes.sendAMessageView);
  }

  Future navigateToMessageView(title, message) async {
    MessageArgument argument = MessageArgument(title: title,message: message);
     await _navigationService.navigateTo(Routes.messageView,arguments: argument);
  }

  Future navigateToMessage() async {
    MessageArgument  argument = MessageArgument(title: '',message: '');
    await _navigationService.navigateTo(Routes.messageView, arguments: argument);
  }
}

class MessageArgument{
  String title,message;
  List<CustomerContact> selectedCustomers;

  MessageArgument({this.title, this.message, this.selectedCustomers});

}