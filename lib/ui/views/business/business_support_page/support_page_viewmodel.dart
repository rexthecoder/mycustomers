import 'package:stacked/stacked.dart';

class SupportPageViewModel extends BaseViewModel {
  List<String> _items = [
    'Enquires',
    'Suggestions',
    'Bug Fixes',
    'Other',
  ];

  List<String> get items => _items;

  validateFields(value) => value.isEmpty ? 'Please fill' : null;
}
