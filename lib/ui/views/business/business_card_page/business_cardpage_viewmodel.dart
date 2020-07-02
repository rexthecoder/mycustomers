import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/business_card_model.dart';
import 'package:mycustomers/core/services/business_card_service.dart';
import 'package:stacked/stacked.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class BusinessCardPageViewModel extends BaseViewModel {
  /// Fields
  final BusinessCardService _businessCardService =
      locator<IBusinessCardService>();
  bool autoValidate = false;
  String _dropDownValue = '+234';
  BusinessCard _businessCard = BusinessCard.empty();
  List<String> _countryCodes = ['+234', '+254', '+250', '+230'];
  File imageFile;

  /// Getters
  BusinessCard get businessCard => _businessCard;

  List<String> get countryCode => _countryCodes;

  String get dropDownValue => _dropDownValue;

  /// Setters

  /// Methods
  void updateBusinessCard(
      {String storeName,
      String personalName,
      String phoneNumber,
      String emailAddress,
      String address}) {
    _businessCard = _businessCard.copyWith(
      storeName: storeName ?? _businessCard.storeName,
      personalName: personalName ?? _businessCard.personalName,
      phoneNumber: phoneNumber != null
          ? '$_dropDownValue  $phoneNumber'
          : _businessCard.phoneNumber,
      emailAddress: emailAddress ?? _businessCard.emailAddress,
      address: address ?? _businessCard.address,
    );
    notifyListeners();
  }

  void updateCountryCode(String value) {
    _dropDownValue = value;
    if (_businessCard.phoneNumber.contains('+')) {
      _businessCard = _businessCard.copyWith(
        phoneNumber: '$dropDownValue ${_businessCard.phoneNumber.substring(4)}',
      );
    }
    notifyListeners();
  }

  Future<void> saveBusinessCard() async {
    await _businessCardService.saveBusinessCard(businessCard);
    // TODO Show saved display
    await _shareImageAndText();
    notifyListeners();
  }

  _shareImageAndText() async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      await WcFlutterShare.share(
          sharePopupTitle: 'Share Your Business Card',
          subject: businessCard.storeName,
          text: 'My Business Card',
          fileName: 'share.png',
          mimeType: 'image/png',
          bytesOfFile: bytes.buffer.asUint8List());
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> init() async {
    _businessCard = await _businessCardService.getBusinessCard();
    notifyListeners();
  }
}
