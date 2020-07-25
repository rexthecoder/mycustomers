import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'dart:math';
import 'package:mycustomers/core/data_sources/stores/stores_local_data_source.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class ScheduleNotificationsViewModel extends BaseViewModel {
  final dformat = new DateFormat('MMM dd, yyyy');
  DateTime selectedDate = DateTime.now();
  DateTime scheduledDate;
  String newDate;
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;
  DateTime _today = DateTime.now();
  NotificationRemindersService reminders = NotificationRemindersService();
  final NavigationService _navigationService = locator<NavigationService>();

  // This is temporary to give each notification a unique id
  int id = Random().nextInt(100);

  int get selectedDay => _selectedDay;
  setSelectedDay(int selectedDay) => _selectedDay = selectedDay;

  int get selectedMonth => _selectedMonth;
  setSelectedMonth(int selectedMonth) => _selectedMonth = selectedMonth;

  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;

  void setDate(DateTime date) {
    scheduledDate = date;
    newDate = dformat.format(date);
    notifyListeners();
  }

  void scheduleReminder(String heading) {
    reminders.sendNotificationOnce(id, 'You have this pending message to send',
        'Heading: ' + heading, getDateTime());
  }

  // When time picker is added to the screen,
// this would be used to get the date and specific time to alert the user.
  // getDate(TimeOfDay time) {
  //   // final now = new DateTime.now();
  //   return DateTime(scheduledDate.year, scheduledDate.month, scheduledDate.day,
  //       time.hour, time.minute
  //       //fromTimePicker.hour, fromTimePicker.minute
  //       );
  // }

  void updateSelectedTime(dynamic time) {
    _selectedTime = time;
  }

  DateTime getDateTime() {
    return DateTime.parse(
        '${_today.year}-0${scheduledDate.month}-${scheduledDate.day} ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
  }

  Future<void> navigateToMainView() async{
    await _navigationService.clearStackAndShow(Routes.mainViewRoute);

  }
}
