import 'dart:io';
import 'dart:math';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/notifications/notifications_service.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/reminders_viewmodel.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class SendMessageViewModel extends BaseViewModel {
  final MainTransactionViewModel transactions = MainTransactionViewModel();
  final RemindersViewModel reminders = RemindersViewModel();
  // Local notification service
  final _reminder = locator<NotificationRemindersService>();

// Date field and other variables
  final dformat = new DateFormat('MMM dd, yyyy');
  DateTime selectedDate = DateTime.now();
  DateTime scheduledDate;
  String newDate;
  int _selectedDay;
  int _selectedMonth;
  dynamic _selectedTime;
  DateTime _today = DateTime.now();
  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;
  // This is temporary to give each local notification a unique id
  int notificationid = Random().nextInt(100);

  // Method to setDate to user choice date
  void setDate(DateTime date) {
    scheduledDate = date;
    newDate = dformat.format(date);
    print(scheduledDate);
    notifyListeners();
  }

  DateTime getDateTime() {
    return DateTime.parse(
        '${_today.year}-0${scheduledDate.month}-${scheduledDate.day} ${_selectedTime.substring(0, 2)}:${selectedTime.substring(3, 5)}');
  }

// Function to send to implementation class of notification service reminder
  void scheduleReminder() {
    _reminder.sendNotificationOnce(
        notificationid,
        'Reminder: ',
        'You have a debt schedule message to be sent to  ${transactions.contact.name}',
        getDateTime());
  }

  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  TransactionModel get transaction => _transactionService.stransaction;

  String _controllerValue;
  String _messageControllerValue;
  String number = "0786067005";

  String value;

  String description;

  String get messageControllerValue => _messageControllerValue;
  get controllerValue => _controllerValue;

  final currency = new NumberFormat("#,##0", "en_NG");

  final List<String> _messageEntries = <String>[
    "Don't leave me",
    "Happy New year",
    "Debt reminder"
  ];

  List<String> get messageEntries => _messageEntries;

  String initialValue({String newValue}) {
    String text =
        'Dear ${transactions.contact.name}, you have an outstanding payment of $debt. Kindly make payment via www.customerpay.me/cE54-hnegs.';
    if (value == null && newValue == null) {
      value = text;
    } else if (value != null && newValue != null) {
      value = newValue;
    }
    return value;
  }

  String sTransactionValue({String newValue}) {
    String text =
        'Dear ${transactions.contact.name}, you have an outstanding payment of $singleDebt. Kindly make payment via www.customerpay.me/$id.';
    if (value == null && newValue == null) {
      value = text;
    } else if (value != null && newValue != null) {
      value = newValue;
    }
    return value;
  }

  String get singleDebt =>
      transactions.currency.symbol + currency.format(transaction.amount);
  String get id => transaction.tId;

  String get debt =>
      transactions.currency.symbol +
      currency
          .format(transactions.getamount((transactions.bought()).toDouble()));

  void updateFieldValue(String buttonValue) {
    _controllerValue = buttonValue;
    print(_controllerValue);
    notifyListeners();
  }

  void clearMessageFields() {
    _controllerValue = "";
    _messageControllerValue = "";
    notifyListeners();
  }

  void sendMessage(String text) async {
    var regText = Uri.encodeFull(text);
    var uri = 'sms:+${transactions.contact.phoneNumber}?body=$regText';
    if (Platform.isAndroid) {
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    }
  }

  void singleSendMessage({String text, String id}) async {
    var regText = Uri.encodeFull(text);
    var uri = 'sms:+${transactions.contact.phoneNumber}?body=$regText';
    if (Platform.isAndroid) {
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    }
  }
}
