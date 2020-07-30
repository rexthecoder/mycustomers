import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/widgets/timeWheel.dart';
import 'package:stacked/stacked.dart';
import 'send_reminder_viewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/const_color.dart';

class SendMessage extends StatelessWidget {
  final String action, process;
  SendMessage({this.action, this.process});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendMessageViewModel>.reactive(
      builder: (contxt, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: action == 'send'
                  ? AppLocalizations.of(context).sendReminder
                  : AppLocalizations.of(context).scheduleReminder,
              arrowColor: action == 'send' ? BrandColors.secondary : Theme.of(context).textSelectionColor,
              backgroundColor: Theme.of(context).backgroundColor),
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.xMargin(context, 5),
              vertical: SizeConfig.yMargin(context, 5),
            ),
            child: 
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      action == 'schedule'
                          ? Text(
                              AppLocalizations.of(context)
                                  .pickADateAndTypeInYourMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontSize: SizeConfig.textSize(context, 4.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          : Container(
                              height: SizeConfig.xMargin(context, 40),
                              width: SizeConfig.xMargin(context, 80),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.xMargin(context, 2),
                                  vertical: SizeConfig.yMargin(context, 2)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.yMargin(context, 2)),
                                border: Border.all(
                                    color: ThemeColors.gray.shade600),
                              ),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                                maxLengthEnforced: false,
                                onChanged: (value) {
                                  process == 'STrans'
                                      ? model.sTransactionValue(newValue: value)
                                      : model.initialValue(newValue: value);
                                },
                                initialValue: process == 'STrans'
                                    ? model.sTransactionValue()
                                    : model.initialValue(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)
                                      .startTypingYourmessage,
                                ),
                              ),
                            ),
                      action == 'schedule'
                          ? SizedBox(
                              height: SizeConfig.yMargin(context, 3),
                            )
                          : SizedBox(),
                      action == 'schedule'
                          ? InkWell(
                              onTap: () async {
                               final DateTime picked = await showDatePicker(
                                  context: context,
                                  initialDate: model.reminders.selectedDate,
                                  firstDate: DateTime(
                                      int.parse(DateFormat('yyyy')
                                          .format(DateTime.now())),
                                      int.parse(DateFormat('MM')
                                          .format(DateTime.now())),
                                      int.parse(DateFormat('dd')
                                          .format(DateTime.now()))),
                                  lastDate: DateTime(2300),
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        primaryColor: BrandColors.primary,
                                        accentColor: BrandColors.primary,
                                        colorScheme: Theme.of(context)
                                            .colorScheme
                                            .copyWith(
                                                primary: BrandColors.primary),
                                        buttonTheme: ButtonThemeData(
                                            textTheme: ButtonTextTheme.primary),
                                      ),
                                      child: child,
                                    );
                                  },
                                );
                                if (picked != null)
                                  model.reminders.setDate(picked);
                                print(model.reminders.scheduledDate);
                              },
                              child: Container(
                                height: SizeConfig.xMargin(context, 15),
                                width: SizeConfig.xMargin(context, 80),
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.yMargin(context, 2),
                                    horizontal: SizeConfig.xMargin(context, 5)),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xFFD1D1D1), width: 2.0),
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.yMargin(context, 2)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        model.reminders.newDate ??
                                            AppLocalizations.of(context)
                                                .selectDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                              fontSize: SizeConfig.textSize(
                                                  context, 4.5),
                                              color: BrandColors.greyedText,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right:
                                              SizeConfig.xMargin(context, 4)),
                                      child: SvgPicture.asset(
                                          'assets/icons/calendar.svg',
                                          color: BrandColors.greyedText),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      action == 'schedule'
                          ? SizedBox(
                              height: SizeConfig.yMargin(context, 3),
                            )
                          : SizedBox(),
                      action == 'schedule'
                          ? Container(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: TimeWheel(
                                  updateTimeChanged: (val) =>
                                      model.reminders.updateSelectedTime(val),
                                ),
                              ),
                            )
                          : Container(),
                      action == 'schedule'
                          ? SizedBox(
                              height: SizeConfig.yMargin(context, 3),
                            )
                          : SizedBox(),
                      action == 'schedule'
                          ? Container(
                              height: SizeConfig.xMargin(context, 40),
                              width: SizeConfig.xMargin(context, 80),
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.xMargin(context, 2),
                                  vertical: SizeConfig.yMargin(context, 2)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.yMargin(context, 2)),
                                border: Border.all(
                                    color: ThemeColors.gray.shade600),
                              ),
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                                maxLengthEnforced: false,
                                onChanged: (value) {
                                  process == 'STrans'
                                      ? model.sTransactionValue(newValue: value)
                                      : model.initialValue(newValue: value);
                                },
                                initialValue: process == 'STrans'
                                    ? model.sTransactionValue()
                                    : model.initialValue(),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)
                                      .startTypingYourmessage,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: SizeConfig.yMargin(context, 10),
                      ),
                      Container(
                        width: SizeConfig.xMargin(context, 80),
                        child: CustomRaisedButton(
                          child: Container(),
                          btnColor: action == 'send' ? BrandColors.secondary : BrandColors.primary,
                          txtColor: ThemeColors.background,
                          borderColor: action == 'send' ? BrandColors.secondary : BrandColors.primary,
                          btnText: action == 'send'
                              ? AppLocalizations.of(context).send
                              : AppLocalizations.of(context).schedule,
                          onPressed: () {
                            if (action == 'schedule') {
                              if (model.reminders.newDate == null) {
                                print(model.value);
                                print(model.reminders.newDate);
                                flusher(
                                    AppLocalizations.of(context)
                                        .fieldShouldNotBeEmpty,
                                    context);
                              } else {
                                print(model.value);
                                print(model.reminders.newDate);
                                flusher(
                                    'Your Reminder has been set successfully',
                                    context);
                                Future.delayed(Duration(seconds: 1), () {
                                  model.reminders.navigateToRemindersView();
                                });
                                model.reminders.scheduleReminder();
                              }
                              if (model.value.length < 1) {
                                flusher(
                                    AppLocalizations.of(context)
                                        .fieldShouldNotBeEmpty,
                                    context);
                              }
                            } else if (action == 'send') {
                              print(model.value);
                              process == 'STrans'
                                  ? model.singleSendMessage(
                                      text: model.sTransactionValue(),
                                      id: model.transaction.tId)
                                  : model.sendMessage(model.initialValue());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
            //   ],
            // ),
          ),
        );
      },
      viewModelBuilder: () => SendMessageViewModel(),
    );
  }
}
