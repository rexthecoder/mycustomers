import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'reminders_view_model.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class RemindersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RemindersViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customizeAppBar(context, 1,
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
                    InkWell(
                        onTap: model.navigateToSendReminderDebtList,
                        child: Container(
                          height: SizeConfig.yMargin(context, 7),
                          width: SizeConfig.xMargin(context, 60),
                          decoration: BoxDecoration(
                              color: BrandColors.primary,
                              borderRadius: BorderRadius.circular(
                                SizeConfig.yMargin(context, 2),
                              )),
                          child: Align(
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).sendReminder,
                                  style:
                                      TextStyle(color: ThemeColors.background),
                                ),
                              )),
                        )),
                    //),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 7),
                    ),
                    Expanded(child: Text('No Scheduled Reminder')),
                    InkWell(
                      onTap: model.navigateToScheduleReminderDebtList,
                      child: Container(
                        height: SizeConfig.yMargin(context, 7),
                        width: SizeConfig.xMargin(context, 60),
                        decoration: BoxDecoration(
                          color: BrandColors.primary,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.yMargin(context, 2)),
                        ),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).scheduleReminder,
                                style: TextStyle(color: ThemeColors.background),
                              ),
                            )),
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
