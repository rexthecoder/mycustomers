import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class OnboardingViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  OnboardingViewModel(BuildContext context) {
    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);
  }

  Future setup() async {
    await Future.value();
    await _navigationService.replaceWith(Routes.languageViewRoute);
  }


}
