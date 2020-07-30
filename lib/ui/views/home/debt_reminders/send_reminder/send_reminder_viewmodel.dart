import 'dart:io';
import 'package:mycustomers/ui/views/home/debt_reminders/main_reminders_view/reminders_viewmodel.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class SendMessageViewModel extends BaseViewModel {
  final MainTransactionViewModel transactions = MainTransactionViewModel();
  final RemindersViewModel reminders = RemindersViewModel();

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
    String text = 'Dear ${transactions.contact.name}, you have an outstanding payment of $debt, kindly make payment via www.customerpay.me/cE54-hnegs';
    if (value == null && newValue == null) {
      value = text;
    } else if (value != null && newValue != null) {
      value = newValue;
    }
    return value;
  }

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
    var uri =
        'sms:+${transactions.contact.phoneNumber}?body=$regText%20\nPlease%20make%20payment%20via%20this%20link:https://www.customerpay.me/cE54-hnegs';
    if (Platform.isAndroid) {
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    }
  }
}
