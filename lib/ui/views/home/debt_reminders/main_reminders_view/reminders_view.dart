import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'reminders_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class RemindersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RemindersViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customizeAppBar(context, 1.3,
                title: 'Reminders',
                backgroundColor: Theme.of(context).backgroundColor),
            body: Container(
              margin: EdgeInsets.symmetric(
                vertical: SizeConfig.yMargin(context, 5),
                //horizontal: SizeConfig.xMargin(context, 5),
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                width: SizeConfig.xMargin(context, 60),
                      child: CustomRaisedButton(
                        child: Container(),
                        btnColor: BrandColors.secondary,
                        txtColor: ThemeColors.background,
                        borderColor: BrandColors.secondary,
                        btnText: 'Send a quick reminder',
                        onPressed: () {
                          // viewModel.signUpTest();
                          model.navigateToSendReminderDebtList();
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 7),
                    ),
                    Expanded(child: Center(child: Text("There is no reminder scheduled yet"))),
                    Container(
                      width: SizeConfig.xMargin(context, 80),
                      child: CustomRaisedButton(
                        child: Container(),
                        btnColor: BrandColors.primary,
                        txtColor: ThemeColors.background,
                        borderColor: BrandColors.primary,
                        btnText: 'Schedule a new reminder',
                        onPressed: () {
                          // viewModel.signUpTest();
                          model.navigateToScheduleReminderDebtList();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => RemindersViewModel());
  }
}
