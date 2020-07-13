import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_model.dart';
import 'package:mycustomers/core/services/business_card_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class BusinessCardPageViewModel extends BaseViewModel {
  /// Fields
  final BusinessCardService _businessCardService =
      locator<IBusinessCardService>();
  final NavigationService _navigationService = locator<NavigationService>();

  BusinessCard _businessCard = BusinessCard.empty();
  File imageFile;

  /// Getters
  BusinessCard get businessCard => _businessCard;

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
      phoneNumber: phoneNumber ?? _businessCard.phoneNumber,
      emailAddress: emailAddress ?? _businessCard.emailAddress,
      address: address ?? _businessCard.address,
    );
    notifyListeners();
  }

  Future<void> saveBusinessCard() async {
    await _businessCardService.saveBusinessCard(businessCard);
    notifyListeners();
  }

  Future<void> shareImageAndText() async {
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

  Future navigateToBusinessCardPage() async {
    await _navigationService.navigateTo(Routes.businessCardRoute);
  }
}
