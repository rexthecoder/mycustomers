import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:stacked/stacked.dart';
import 'package:worm_indicator/indicator.dart';
import 'package:worm_indicator/shape.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PageView(
              physics: ClampingScrollPhysics(),
              controller: model.pageController,
              children: [
                _Pages(
                  'assets/images/onboarding/onboarding1.png',
                  AppLocalization.of(context).onboardingWelcomeText,
                  AppLocalization.of(context).onboardingWelcomeDesc,
                ),
                _Pages(
                  'assets/images/onboarding/onboarding2.png',
                  AppLocalization.of(context).pushAReminder,
                  AppLocalization.of(context).pushAReminderDesc,
                ),
                _Pages(
                  'assets/images/onboarding/onboarding3.png',
                  AppLocalization.of(context).collectYourMoney,
                  AppLocalization.of(context).collectYourMoneyDesc,
                ),
                _Pages(
                  'assets/images/onboarding/onboarding4.png',
                  AppLocalization.of(context).engagedWithYourPeople,
                  AppLocalization.of(context).engagedWithYourPeopleDesc,
                ),
              ],
            ),
            Positioned(
              bottom: SizeConfig.yMargin(context, 22),
              left: 0,
              right: 0,
              child: WormIndicator(
                indicatorColor: BrandColors.primary,
                color: ThemeColors.gray.shade800,
                length: 4,
                controller: model.pageController,
                shape: Shape(
                  size: SizeConfig.yMargin(context, 1.2),
                  shape: DotShape.Circle,
                  spacing: SizeConfig.xMargin(context, 5),
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.yMargin(context, 12),
              child: InkWell(
                onTap: () {
                  model.navigateToSignUp();
                },
                child: btnHome(AppLocalization.of(context).getStartedButton, BrandColors.primary,
                    ThemeColors.background, context),
              ),
            ),
            Positioned(
              bottom: SizeConfig.yMargin(context, 3),
              child: InkWell(
                onTap: () {
                  model.navigateToSignIn();
                },
                child: btnHome(AppLocalization.of(context).signIn, ThemeColors.background,
                    BrandColors.primary, context),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
      onModelReady: (model) => model.initState(),
    );
  }
}

class _Pages extends StatelessWidget {
  final String img1;
  final String txt1;
  final String txt2;

  const _Pages(this.img1, this.txt1, this.txt2);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRect(
          child: Image(
            height: SizeConfig.yMargin(context, 50),
            image: AssetImage(img1),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: SizeConfig.yMargin(context, 8)),
        Text(
          txt1,
          style: TextStyle(
            fontSize: SizeConfig.textSize(context, 6),
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: SizeConfig.yMargin(context, 1.2)),
        Text(
          txt2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.textSize(context, 5),
          ),
        ),
      ],
    );
  }
}
