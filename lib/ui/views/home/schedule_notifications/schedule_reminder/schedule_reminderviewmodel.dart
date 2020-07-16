import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ScheduleNotificationsViewModel extends BaseViewModel {
  final dformat = new DateFormat('MMM dd, yyyy');
  DateTime selectedDate = DateTime.now();
  DateTime scheduledDate;
  String newDate;

  void setDate(DateTime date) {
    scheduledDate = date;
    newDate = dformat.format(date);
    notifyListeners();
  }
}
