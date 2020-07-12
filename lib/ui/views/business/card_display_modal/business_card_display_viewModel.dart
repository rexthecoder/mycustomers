import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_model.dart';
import 'package:mycustomers/core/services/business_card_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class BusinessCardDisplayViewModel extends BaseViewModel{
  final BusinessCardService _businessCardService = locator<IBusinessCardService>();
  final NavigationService _navigationService = locator<NavigationService>();

  BusinessCard _businessCard = BusinessCard.empty();

  BusinessCard get businessCard => _businessCard;
  File imageFile;




 Future navigateToEditProfilePage() async {
    await _navigationService.navigateTo(Routes.editProfileViewRoute);
  }

  Future<void> init() async {
    _businessCard = await _businessCardService.getBusinessCard();
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
  }}