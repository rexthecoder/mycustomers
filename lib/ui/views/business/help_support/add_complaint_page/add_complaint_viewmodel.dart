import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/complaint/complaint_local.dart';
import 'package:mycustomers/core/models/hive/complaint/complaint_h.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddComplaintViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ComplaintLocalDataSource _comp = locator<ComplaintLocalDataSource>();
  final DialogService _dialogService = locator<DialogService>();

  String subject = '';
  String message = '';

  Future navigateToAddComplaint() async {
    await _navigationService.navigateTo(Routes.privacy_policy);
  }

  Future<void> sendComplaint() async {
    // TODO Implement send Complaint
    _dialogService.registerCustomDialogUi(buildLoaderDialog);
    _dialogService.showCustomDialog(
        title: '');
    await _comp.createComplaint(Complaint.fromJson({'subject': subject, 'message': message}));
    _dialogService.completeDialog(DialogResponse());
    _navigationService.back();
  }

  String validateFields(String value) => (value?.length ?? 0) < 11 ? 'Please enter a subject and message with at least 11 characters' : null;

  onChangeMessage(String value) => message = value;

  onChangeSubject(String value) => subject = value;
}
