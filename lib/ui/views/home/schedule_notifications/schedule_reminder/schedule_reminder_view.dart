import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'schedule_reminder_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/views/home/schedule_notifications/schedule_reminder/widgets/timeWheel.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ScheduleNotifications extends StatelessWidget {
  final _heading = TextEditingController();
  final _description = TextEditingController();
  final _schedule = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleNotificationsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customizeAppBar(context, 1.0,
                title: AppLocalizations.of(context).scheduleReminder,
                arrowColor: Theme.of(context).textSelectionColor,
                backgroundColor: Theme.of(context).backgroundColor),
            body: Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .pickADateAndTypeInYourMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize:
                                          SizeConfig.textSize(context, 4.4),
                                      fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Form(
                                key: _schedule,
                                child: Column(
                                  children: <Widget>[
                                    _ReminderForm(
                                      heading: _heading,
                                      description: _description,
                                    ),
                                    CustomRaisedButton(
                                      txtColor: ThemeColors.background,
                                      btnColor: BrandColors.primary,
                                      btnText: 'Schedule',
                                      borderColor: BrandColors.primary,
                                      child: Container(
                                          height:
                                              SizeConfig.yMargin(context, 7)),
                                      onPressed: () {
                                        if (_schedule.currentState.validate()) {
                                          model.scheduleReminder(_heading.text);
                                          flusher(
                                              'Your Reminder has been set successfully',
                                              context);

                                          model.navigateToMainView();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => ScheduleNotificationsViewModel());
  }
}

class _ReminderForm
    extends HookViewModelWidget<ScheduleNotificationsViewModel> {
  final String hintText;
  final TextEditingController heading;
  final TextEditingController description;
  const _ReminderForm({this.hintText, this.description, this.heading, Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, ScheduleNotificationsViewModel model) {
    // final _schedule = GlobalKey<FormState>();
    // var height = MediaQuery.of(context).size.height;
    return Column(children: <Widget>[
      InkWell(
        onTap: () async {
          final DateTime picked = await showDatePicker(
            context: context,
            initialDate: model.selectedDate,
            firstDate: DateTime(
                int.parse(DateFormat('yyyy').format(DateTime.now())),
                int.parse(DateFormat('MM').format(DateTime.now())),
                int.parse(DateFormat('dd').format(DateTime.now()))),
            lastDate: DateTime(2300),
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: BrandColors.primary,
                  accentColor: BrandColors.primary,
                  colorScheme: Theme.of(context)
                      .colorScheme
                      .copyWith(primary: BrandColors.primary),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child,
              );
            },
          );
          if (picked != null) model.setDate(picked);
          print(model.scheduledDate);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.yMargin(context, 2),
              horizontal: SizeConfig.xMargin(context, 5)),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFD1D1D1), width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  model.newDate ?? AppLocalizations.of(context).selectDate,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontSize: SizeConfig.textSize(context, 4.5),
                        color: BrandColors.greyedText,
                      ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: SizeConfig.xMargin(context, 4)),
                child: SvgPicture.asset('assets/icons/calendar.svg',
                    color: BrandColors.greyedText),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.topCenter,
        child: Container(
          child: TimeWheel(
            updateTimeChanged: (val) => model.updateSelectedTime(val),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
          child: _ReminderField(
        hintText: AppLocalizations.of(context).typeAHeading,
        controller: heading,
      )),
      SizedBox(
        height: 20,
      ),
      Container(
        child: _ReminderField(
          hintText: AppLocalizations.of(context).startTypingYourmessage,
          controller: description,
        ),
      ),
      SizedBox(
        height: 40,
      ),
    ]);
  }
}

class _ReminderField
    extends HookViewModelWidget<ScheduleNotificationsViewModel> {
  final String hintText;
  final controller;
  const _ReminderField({this.hintText, this.controller, Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, ScheduleNotificationsViewModel model) {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        maxLengthEnforced: false,
        keyboardType: TextInputType.text,
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return AppLocalizations.of(context).fieldShouldNotBeEmpty;
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: BrandColors.greyedText),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.gray, width: 2.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.gray, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.gray, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ThemeColors.gray, width: 2.0)),
        ),
        style: TextStyle(
          color: Theme.of(context).textSelectionColor,
        ));
  }
}
