import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stacked/stacked.dart';

import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: FancyOnBoarding(
          doneButtonText: "Let's Go",
          skipButtonText: "Skip",
          pageList: pageList,
          onDoneButtonPressed: () => model.setup(),
          onSkipButtonPressed: () => model.setup(),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}

//list of PageModel to be set on the onBoarding Screens
final pageList = [
  PageModel(
      color: const Color(0xFF45ADA7),
      heroAssetPath: 'assets/images/onboarding/onboarding1.png',
      title: Text('MyCustomer',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFFFDA741),
            fontSize: 36.sp,
          )),
      body: Text('Track your debts',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1D6AFF),
            fontSize: 18.sp,
          )),
      iconAssetPath: ''),
  PageModel(
      color: const Color(0xFF3DBED0),
      heroAssetPath: 'assets/images/onboarding/onboarding2.jpg',
      title: Text('MyCustomer',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFFFDA741),
            fontSize: 36.sp,
          )),
      body: Text('Market your Business',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1D6AFF),
            fontSize: 18.sp,
          )),
      iconAssetPath: ''),
  PageModel(
    color: const Color(0xFF7ED8CA),
    heroAssetPath: 'assets/images/onboarding/onboarding3.jpg',
    title: Text('MyCustomer',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFFFDA741),
          fontSize: 36.sp,
        )),
    body: Text('Manage your business',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF1D6AFF),
          fontSize: 18.sp,
        )),
    iconAssetPath: '',
  ),
];
