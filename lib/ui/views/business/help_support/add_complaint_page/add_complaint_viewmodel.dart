import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/complaint/complaint_local.dart';
import 'package:mycustomers/core/models/hive/complaint/complaint_h.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddComplaintViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ComplaintLocalDataSource _comp = locator<ComplaintLocalDataSource>();

  String subject = '';
  String message = '';

  Future navigateToAddComplaint() async {
    await _navigationService.navigateTo(Routes.privacy_policy);
  }

  Future<void> sendComplaint() async {
    // TODO Implement send Complaint
    await _comp.createComplaint(Complaint.fromJson({'subject': subject, 'message': message}));
    _navigationService.back();
  }

  validateFields(value) => value.isEmpty ? 'Please fill' : null;

  onChangeMessage(String value) => message = value;

  onChangeSubject(String value) => subject = value;
}
