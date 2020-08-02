import 'package:stacked/stacked.dart';

class PrivacyPolicyViewModel extends BaseViewModel {

  String text = '';

  bool checkbusy = true;

  Future delay() async {
    setBusy(true);
    await Future.delayed(Duration(milliseconds: 7000));
    setBusy(false);
    checkbusy = false;
    notifyListeners();
  }

}