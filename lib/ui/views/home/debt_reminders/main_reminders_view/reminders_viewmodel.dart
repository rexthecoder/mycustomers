import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'dart:math';
import 'package:stacked_services/stacked_services.dart';

class RemindersViewModel extends BaseViewModel {
  final dformat = new DateFormat('MMM dd, yyyy');
  DateTime selectedDate = DateTime.now();
  DateTime scheduledDate;
  String newDate;
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;
  DateTime _today = DateTime.now();
  final NotificationRemindersService reminders = NotificationRemindersService();
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

  void scheduleReminder() {
    reminders.sendNotificationOnce(id, 'Reminder: ',
         'You have a pending message to send', getDateTime());
  }

  void updateSelectedTime(dynamic time) {
    _selectedTime = time;
  }

  DateTime getDateTime() {
    return DateTime.parse(
        '${_today.year}-0${scheduledDate.month}-${scheduledDate.day} ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
  }

  Future<void> navigateToRemindersView() async{
    await _navigationService.clearStackAndShow(Routes.mainViewRoute);
  }

  Future<void> navigateToSendMessage() async {
    await _navigationService.navigateTo(Routes.sendNotificationMessage);
  }

  Future<void> navigateToSchedule() async {
    await _navigationService.navigateTo(Routes.scheduleNotifications);
  }

  Future<void> navigateToSendReminderDebtList() async {
    await _navigationService.navigateTo(Routes.sendReminderDebtList);
  }

  Future<void> navigateToScheduleReminderDebtList() async {
    await _navigationService.navigateTo(Routes.scheduleReminderDebtList);
  }
}
