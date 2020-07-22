import 'package:stacked/stacked.dart';

class SendMessageViewModel extends BaseViewModel {

  final List<String> _messageEntries = <String>[
    "Don't leave me",
    "Happy New year",
    "Debt reminder"
  ];

  String number = "0786067005";

  List<String> get messageEntries => _messageEntries;

}