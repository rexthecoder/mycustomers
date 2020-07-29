import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/services/password_manager_services.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class RemovePinSettingsPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PasswordManagerService _passwordManagerService =
      locator<PasswordManagerService>();

  final LogsLocalDataSourceImpl _logService =
      locator<LogsLocalDataSourceImpl>();

  void onEnterPinCompleted(String value, BuildContext context,
      TextEditingController editingControllerText) async {
    String passFrmDb = await _passwordManagerService
        .getPassword(); // get the password stored in the db
    int check = passFrmDb.compareTo(value); // compare they are equal

    if (check == 0) {
      await _passwordManagerService.deleteSetPin();
      setPin(false);
      showAlertDilaog(context);
    } else if (check < 0 || check > 0) {
      _passwordManagerService.showUnmatchedPinErrorMessage();
      clearValueIfPinsDoNotMatch(editingControllerText);
    } else {
      _passwordManagerService.showRemoveErrorMessage();
    }
  }

  void setPin(bool value) {
    _passwordManagerService.setPin(value);
    _logService.getValues(null, DateTime.now(), 'remove-pin', '', false);
    notifyListeners();
  }

  void clearValueIfPinsDoNotMatch(TextEditingController textEditingController) {
    textEditingController.clear();
  }

  Future<void> showAlertDilaog(BuildContext context) async {
    // set up the button
    Widget continueButton = Center(
      child: Container(
        height: SizeConfig.yMargin(context, 7),
        width: SizeConfig.xMargin(context, 100),
//        padding: EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 8)),
        decoration: BoxDecoration(
          color: BrandColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: FlatButton(
          child: Text("Continue",
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeColors.background)),
          onPressed: () {
            _navigationService.popRepeated(2);
          },
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: CircleAvatar(
          radius: SizeConfig.yMargin(context, 5),
          backgroundColor: ThemeColors.success,
          child: Icon(
            Icons.check,
            color: BrandColors.primary,
            size: SizeConfig.yMargin(context, 4),
          )),
      content: Text(
        "Pin Removed",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: SizeConfig.yMargin(context, 2),
            color: BrandColors.primary),
      ),
      actions: [
        continueButton,
      ],
      actionsPadding: EdgeInsets.all(10),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
