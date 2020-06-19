import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  String _title = 'Home View';
  String get title => _title;

  final double _amount = 100.86;
  double get amount => _amount;

  void btnViewDetails() {
    print('hello');
  }
}
