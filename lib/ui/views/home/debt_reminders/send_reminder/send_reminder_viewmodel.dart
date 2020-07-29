import 'dart:io';
import 'package:mycustomers/ui/views/home/debt_reminders/main_remindersview/reminders_view_model.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stacked/stacked.dart';

class SendMessageViewModel extends BaseViewModel {
  String _controllerValue;
  String _messageControllerValue;
  String get messageControllerValue => _messageControllerValue;
  get controllerValue => _controllerValue;

  final List<String> _messageEntries = <String>[
    "Don't leave me",
    "Happy New year",
    "Debt reminder"
  ];

  String number = "0786067005";

  String value = 'Dear Sir/Ma, you have an outstanding payment of ${debt}';
  String _description;
  String get description => _description;

  List<String> get messageEntries => _messageEntries;

  final MainTransactionViewModel transactions = MainTransactionViewModel();
  final RemindersViewModel reminders = RemindersViewModel();

  int get debt => transactions.bought();

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
