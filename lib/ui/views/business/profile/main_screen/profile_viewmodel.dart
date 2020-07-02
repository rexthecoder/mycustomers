import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class MainProfilePageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();


  String _title='Profile';
  String get title => _title;

  String _btnText='Edit';
  String get btnText => _btnText;

  String _nameLabel= 'Name';
  String _businessNameLabel = 'Business\nName';

  String get nameLabel => _nameLabel;
  String get businessNameLabel => _businessNameLabel;

//TODO the names should be gotten from the user model

  get updateUserName => null;

  get updateBusinessName => null;

  Future navigateToEditProfilePage() async {
    await _navigationService.clearStackAndShow(Routes.editProfileViewRoute);
  }



}