import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:stacked/stacked.dart';

class BusinessCardPageViewModel extends BaseViewModel {
  BusinessCard _businessCard = BusinessCard.empty();

  BusinessCard get businessCard => _businessCard;

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
      phoneNumber: phoneNumber ?? _businessCard .phoneNumber,
      emailAddress: emailAddress ?? _businessCard .emailAddress,
      address: address ?? _businessCard .address,
    );
    notifyListeners();
  }
}
