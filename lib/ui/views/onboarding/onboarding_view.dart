import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:stacked/stacked.dart';

import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => PlatformScaffold(
        //Pass pageList and the mainPage route.
        body: FancyOnBoarding(
          doneButtonText: "Done",
          skipButtonText: "Skip",
          pageList: pageList,
          onDoneButtonPressed: () =>
              Navigator.of(context).pushReplacementNamed('/mainPage'),
          onSkipButtonPressed: () =>
              Navigator.of(context).pushReplacementNamed('/mainPage'),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}

//Create a list of PageModel to be set on the onBoarding Screens.
final pageList = [
  PageModel(
      color: const Color(0xFF678FB4),
      heroAssetPath: 'assets/png/hotels.png',
      title: Text('Hotels',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All hotels and hostels are sorted by hospitality rating',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/png/key.png'),
  PageModel(
      color: const Color(0xFF65B0B4),
      heroAssetPath: 'assets/png/banks.png',
      title: Text('Banks',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body:
          Text('We carefully verify all banks before adding them into the app',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
      iconAssetPath: 'assets/png/wallet.png'),
  PageModel(
    color: const Color(0xFF9B90BC),
    heroAssetPath: 'assets/png/stores.png',
    title: Text('Store',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 34.0,
        )),
    body: Text('All local stores are categorized for your convenience',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        )),
    iconAssetPath: 'assets/png/shopping_cart.png',
  ),
];
