import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddComplaintViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String subject = '';
  String message = '';

  Future navigateToAddComplaint() async {
    await _navigationService.navigateTo(Routes.privacy_policy);
  }

  Future sendComplaint() async {
    // TODO Implement send Complaint
  }

  validateFields(value) => value.isEmpty ? 'Please fill' : null;

  onChangeMessage(String value) => message = value;

  onChangeSubject(String value) => subject = value;
}
