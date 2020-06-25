import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:stacked/stacked.dart';

class BusinessCardPageViewModel extends BaseViewModel {
  BusinessCard _businessCard = BusinessCard.empty();

  BusinessCard get businessCard => _businessCard;

  String _dropDownValue = '+234';
  List<String> _countryCodes = ['+234', '+254', '+250', '+230'];

  List<String> get countryCode => _countryCodes;

  String get dropDownValue => _dropDownValue;

  bool autoValidate = false;

  void updateBusinessCard(
      {String storeName,
      String personalName,
      String phoneNumber,
      String emailAddress,
      String address}) {
    _businessCard = _businessCard.copyWith(
      storeName: storeName ?? _businessCard.storeName,
      personalName: personalName ?? _businessCard.personalName,
      phoneNumber:
          '$_dropDownValue ${phoneNumber ?? _businessCard.phoneNumber}',
      emailAddress: emailAddress ?? _businessCard.emailAddress,
      address: address ?? _businessCard.address,
    );
    notifyListeners();
  }

  void updateCountryCode(String value) {
    _dropDownValue = value;
    if (_businessCard.phoneNumber.contains('+')) {
      _businessCard = _businessCard.copyWith(
          phoneNumber: '$dropDownValue ${_businessCard.phoneNumber.substring(4)}');
    }
    notifyListeners();
  }
}
