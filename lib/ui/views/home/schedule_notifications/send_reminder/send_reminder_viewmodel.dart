import 'package:stacked/stacked.dart';

class SendMessageViewModel extends BaseViewModel {
  String _controllerValue;
  String _messageControllerValue;
  String get messageControllerValue=> _messageControllerValue;
  get controllerValue=>_controllerValue;

  final List<String> _messageEntries = <String>[
    "Don't leave me",
    "Happy New year",
    "Debt reminder"
  ];

  String number = "0786067005";

  List<String> get messageEntries => _messageEntries;

  void updateFieldValue(String buttonValue){
    _controllerValue = buttonValue;
    print(_controllerValue);
    notifyListeners();

  }

  void clearMessageFields(){
    _controllerValue="";
    _messageControllerValue="";
     notifyListeners();

  }

}