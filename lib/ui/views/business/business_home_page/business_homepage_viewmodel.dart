import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class BusinessHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String get profileCardTitle => StoreRepository?.currentStore?.name ?? 'None';
  String get profileCardSubtitle => StoreRepository?.currentStore?.address ?? '---';

  BusinessCard _businessCard = BusinessCard.empty();

  BusinessCard get businessCard => _businessCard;
  File imageFile;

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
 

  Future navigateToProfilePage() async {
    await _navigationService.navigateTo(Routes.profileViewRoute);
  }

  Future navigateToBusinessCardPage() async {
    await _navigationService.navigateTo(Routes.businessCardRoute);
  }

  Future navigateToSupportPage() async {
    await _navigationService.navigateTo(Routes.supportViewRoute);
  }

  Future navigateToSettingsPage() async {
    await _navigationService.navigateTo(Routes.bussinessSettingsPage);
  }
}
