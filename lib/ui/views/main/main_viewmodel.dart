import 'package:mycustomers/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends BaseViewModel {
  int _index = 0;

  int get index => _index;

  void changeTab(int index) {
    _index = index;
    notifyListeners();
  }

}
