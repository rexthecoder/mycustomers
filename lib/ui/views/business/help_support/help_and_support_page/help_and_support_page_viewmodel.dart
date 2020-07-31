import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HelpAndSupportPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();


  Future navigateToAddComplaint() async {
    await _navigationService.navigateTo(Routes.add_complaint);
  }

//  List<String> _items = [
//    'Enquires',
//    'Suggestions',
//    'Bug Fixes',
//    'Other',
//  ];
//
//  List<String> get items => _items;
//
//  validateFields(value) => value.isEmpty ? 'Please fill' : null;
}
