import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
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

  final NavigationService _navigationService = locator<NavigationService>();

  int get selectedDay => _selectedDay;
  setSelectedDay(int selectedDay) => _selectedDay = selectedDay;

  int get selectedMonth => _selectedMonth;
  setSelectedMonth(int selectedMonth) => _selectedMonth = selectedMonth;

  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;

  void setDate(DateTime date) {
    scheduledDate = date;
    newDate = dformat.format(date);
    print(scheduledDate);
    notifyListeners();
  }

  void updateSelectedTime(dynamic time) {
    _selectedTime = time;
  }

  DateTime getDateTime() {
    return DateTime.parse(
        '${_today.year}-0${scheduledDate.month}-${scheduledDate.day} ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
  }

  Future<void> navigateToSendReminderDebtList() async {
    await _navigationService.navigateTo(Routes.sendReminderDebtList);
  }

  Future<void> navigateToScheduleReminderDebtList() async {
    await _navigationService.navigateTo(Routes.scheduleReminderDebtList);
  }
}
