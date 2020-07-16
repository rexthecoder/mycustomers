import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './schedule_reminderviewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScheduleNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    var _heading = useTextEditingController();
    var _description = useTextEditingController();
    NotificationRemindersService reminders = NotificationRemindersService();
    return ViewModelBuilder<ScheduleNotificationsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customizeAppBar(context, 1.0,
                title: 'Schedule Reminder',
                arrowColor: Theme.of(context).textSelectionColor),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Pick a date and type in your message',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: model.selectedDate,
                          firstDate: DateTime(
                              int.parse(
                                  DateFormat('yyyy').format(DateTime.now())),
                              int.parse(
                                  DateFormat('MM').format(DateTime.now())),
                              int.parse(
                                  DateFormat('dd').format(DateTime.now()))),
                          lastDate: DateTime(2300),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                primaryColor: BrandColors.primary,
                                accentColor: BrandColors.primary,
                                colorScheme: Theme.of(context)
                                    .colorScheme
                                    .copyWith(primary: BrandColors.primary),
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
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
                            vertical: ScreenUtil().setHeight(15),
                            horizontal: ScreenUtil().setWidth(15)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFD1D1D1), width: 2.0),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                model.newDate ?? 'Select Date',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      fontSize: ScreenUtil().setSp(16),
                                      color: BrandColors.greyedText,
                                    ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(15)),
                              child: SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  color: BrandColors.greyedText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      child: TextField(
                        controller: _heading,
                        style: TextStyle(height: height * 0.002),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Type a heading',
                          hintStyle: TextStyle(color: BrandColors.greyedText),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      child: TextField(
                        controller: _description,
                        style: TextStyle(height: height * 0.002),
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Start typing your message',
                          hintStyle: TextStyle(color: BrandColors.greyedText),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ThemeColors.gray, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Container(
                      height: height * 0.06,
                      child: MaterialButton(
                        color: BrandColors.primary,
                        elevation: 2,
                        onPressed: () {
                          reminders.sendNotificationOnce(
                              0, _heading.text, "", model.scheduledDate);
                          Navigator.pushNamed(context, '/mainTransaction');
                          print(_heading.text + _description.text);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Center(
                          child: Text(
                            'Schedule',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: ThemeColors.background,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => ScheduleNotificationsViewModel());
  }
}
