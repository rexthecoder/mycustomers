import 'package:stacked/stacked.dart';

class SupportPageViewModel extends BaseViewModel {
  
  String _item = 'Subject';
  String get item => _item;

  List<String> _items = [
    //TODO: Add Dropdown Items
    'first',
    'second', 'third'
  ];

  List<String> get items => _items;

  void setItem(String item){
    _item = item;
    notifyListeners();
  }

  validateFields(value) => value.isEmpty ? 'Please fill' : null;
}
