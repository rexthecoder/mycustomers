import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';
import 'package:mycustomers/core/repositories/business_card/business_card_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/profile_service.dart';
import 'package:mycustomers/core/models/hive/user_profile/profile_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class BusinessHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _auth = locator<AuthService>();
  final _profileService = locator<ProfileService>();
  final BusinessCardRepository _businessCardRepository =
  locator<BusinessCardRepository>();

  String get pNum => _auth.currentUser.phoneNumber;


  String get profileCardTitle => 'Profile';

  Store get currentStore => StoreRepository.currentStore;

  String get profileCardSubtitle =>
      StoreRepository?.currentStore?.address ?? '---';

  //Profile get userP => _profileService.getProfile();

  Profile getProfile() {
    return _profileService.getProfile(StoreRepository?.currentStore?.id);
  }

  Image imageFromBaseString(String base64String, BuildContext context){
     return Image.memory(base64Decode(base64String),
     width: SizeConfig.xMargin(context, 50),
      height: SizeConfig.xMargin(context, 50),
      fit: BoxFit.cover,
    );
  }

  Future navigateToProfilePage() async {
    // TODO fix profile page
    await _navigationService.navigateTo(Routes.editProfileViewRoute);
    _businessCard = await _businessCardRepository.getBusinessCard();
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

   /// Fields
  BusinessCardH _businessCard = BusinessCardH.empty();

  /// Getters
  BusinessCardH get businessCard => _businessCard;

}
