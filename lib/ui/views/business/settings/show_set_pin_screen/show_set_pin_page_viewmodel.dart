import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ShowSetPinViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PasswordManagerService _passwordManagerService =
      locator<PasswordManagerService>();

  void onEnterPinCompleted(
      String value, TextEditingController editingControllerText) async {
    String passFrmDb = await _passwordManagerService
        .getPassword(); // get the password stored in the db
    int check = passFrmDb.compareTo(value); // compare they are equal

    if (check == 0) {
      await navigateToMainScreen();
    } else if (check < 0 || check > 0) {
      _passwordManagerService.showUnmatchedPinErrorMessage();
      clearValueIfPinsDoNotMatch(editingControllerText);
    } else {
      _passwordManagerService.showRemoveErrorMessage();
    }
  }

  void clearValueIfPinsDoNotMatch(TextEditingController textEditingController) {
    textEditingController.clear();
  }

  Future navigateToMainScreen() async {
    await _navigationService.replaceWithTransition(MainView(),
        opaque: true,
        transition: 'rotate',
        duration: Duration(milliseconds: 400));
  }
}
