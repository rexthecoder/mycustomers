import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class MainProfilePageViewModel extends BaseViewModel {

  final NavigationService _navigationService = locator<NavigationService>();

//TODO the names should be gotten from the user model

  get updateUserName => null;

  get updateBusinessName => null;

  Future navigateToEditProfilePage() async {
    await _navigationService.navigateTo(Routes.editProfileViewRoute);
  }



}