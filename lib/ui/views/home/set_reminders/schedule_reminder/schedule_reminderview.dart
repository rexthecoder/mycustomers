import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './schedule_reminderviewmodel.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';

class ScheduleNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScheduleNotificationsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            appBar: customizeAppBar(context, 'Schedule Reminder', 1.0),
          );
        },
        viewModelBuilder: () => ScheduleNotificationsViewModel());
  }
}
