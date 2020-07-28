import 'dart:io';
import 'dart:math';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'package:mycustomers/ui/views/home/debt_reminders/main_remindersview/reminders_view_model.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';

import 'package:mycustomers/core/models/hive/customer_contacts/customer_contact_h.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';

class SendMessageViewModel extends BaseViewModel {
  String _controllerValue;
  String _messageControllerValue;
  String get messageControllerValue => _messageControllerValue;
  get controllerValue => _controllerValue;

  // // This is temporary to give each notification a unique id
  // int id = Random().nextInt(100);

  final List<String> _messageEntries = <String>[
    "Don't leave me",
    "Happy New year",
    "Debt reminder"
  ];

  String number = "0786067005";
  String value = 'Dear Sir/Ma, you have an outstanding payment of N20,000.';
  String _description;
  String get description => _description;

  List<String> get messageEntries => _messageEntries;

  final MainTransactionViewModel transactions = MainTransactionViewModel();
  final RemindersViewModel reminders = RemindersViewModel();

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

  void sendMessage() async {
    var regText = Uri.encodeFull(value);
    var uri =
        'sms:+${transactions.contact.phoneNumber}?body=$regText%20\nPlease%20make%20payment%20using%20this%20link:https://www.google.com/';
    if (Platform.isAndroid) {
      if (await canLaunch(uri)) {
        await launch(uri);
      }
    }
  }

  void updateString(String value) {
    _description = value;
    notifyListeners();
  }

}
