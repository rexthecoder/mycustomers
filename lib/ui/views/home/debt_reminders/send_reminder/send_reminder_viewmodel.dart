import 'dart:io';
import 'dart:math';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/notifications/notifications_service.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/reminders_viewmodel.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class SendMessageViewModel extends BaseViewModel {

  final _transactionService = locator<TransactionLocalDataSource>();
  TransactionModel get transaction => _transactionService.stransaction;
// Date field and other variables
  final dformat = new DateFormat('MMM dd, yyyy');
  DateTime selectedDate = DateTime.now();
  DateTime scheduledDate;
  String newDate;
  dynamic _selectedTime;
  DateTime _today = DateTime.now();
   String _controllerValue;
  String _messageControllerValue;
  String number = "0786067005";

  String value;

  String description;
 final currency = new NumberFormat("#,##0", "en_NG");

  dynamic get selectedTime => _selectedTime;
  setSelectedTime(dynamic selectedTime) => _selectedTime = selectedTime;

  // This is temporary to give each local notification a unique id
  int notificationid = Random().nextInt(100);

final _customerContactService = locator<CustomerContactService>();
  CustomerContact get contact => _customerContactService.contact;

  final _businessService = locator<BussinessSettingService>();
  CountryCurrency get currencies => _businessService.curren;

String get singleDebt =>
      currencies.symbol + currency.format(transaction.amount);
  String get id => transaction.tId;

  String get debt =>
      currencies.symbol +
      currency
          .format(getamount((bought()).toDouble()));

  List<TransactionModel> get transactions =>
      _transactionService.transactions.reversed.toList();

        // Local notification service
  final _reminder = locator<NotificationRemindersService>();

  final NavigationService _navigationService = locator<NavigationService>();

  String get messageControllerValue => _messageControllerValue;
  get controllerValue => _controllerValue;

   Future<void> navigateToRemindersView() async{
    await _navigationService.clearStackAndShow(Routes.mainViewRoute);
  }

 // Method to setDate to user choice date
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

  double getamount(double amt) {
    return amt;
  }
  
  int bought(){
    int sum = 0;
    for (var item in transactions) {
      if (item.amount != 0) {
        sum += item.amount.round();
      }
    }
    return sum;
  }

  String initialValue({String newValue}) {
    String text =
        'Dear ${contact.name}, you have an outstanding payment of $debt. Kindly make payment via www.customerpay.me/cE54-hnegs.';
    if (value == null && newValue == null) {
      value = text;
    } else if (value != null && newValue != null) {
      value = newValue;
    }
    return value;
  }

  String sTransactionValue({String newValue}) {
    String text =
        'Dear ${contact.name}, you have an outstanding payment of $singleDebt. Kindly make payment via www.customerpay.me/$id.';
    if (value == null && newValue == null) {
      value = text;
    } else if (value != null && newValue != null) {
      value = newValue;
    }
    return value;
  }


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
    var uri = 'sms:+${contact.phoneNumber}?body=$regText';
    if (Platform.isAndroid) {
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    }
  }

  void sendSingleMessage({String text, String id}) async {
    var regText = Uri.encodeFull(text);
    var uri = 'sms:+${contact.phoneNumber}?body=$regText';
    if (Platform.isAndroid) {
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    }
  }

  // Function to send to implementation class of notification service reminder
  void scheduleReminder() {
    _reminder.sendNotificationOnce(
        notificationid,
        'Reminder: ',
        'You have a debt reminder to be sent to ${contact.name}',
        getDateTime());
  }
}
