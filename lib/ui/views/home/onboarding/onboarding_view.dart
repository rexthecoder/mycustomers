import 'package:flutter/material.dart';
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
        body: Container(
          height: SizeConfig.yMargin(context, 100),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              PageView(
                // onPageChanged: ,
                physics: ClampingScrollPhysics(),
                controller: model.pageController,
                children: [
                  _Pages(
                    'assets/images/onboarding/onboarding1.png',
                    'Welcome to myCustomer',
                    'We help you to manage your business and \n keep track of records',
                  ),
                  _Pages(
                    'assets/images/onboarding/onboarding2.png',
                    'Push a Reminder',
                    'Send sms reminders to customers that are \n owing you money',
                  ),
                  _Pages(
                    'assets/images/onboarding/onboarding3.png',
                    'Collect your money',
                    'Easily manage customers owing you and \n increase your cash flow',
                  ),
                  _Pages(
                    'assets/images/onboarding/onboarding4.png',
                    'Engage with your people',
                    'Interact with your customers through \n pushing of unique sales messaging',
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
                  child: btnHome('Get Started', BrandColors.primary,
                      ThemeColors.background, context),
                ),
              ),
              Positioned(
                bottom: SizeConfig.yMargin(context, 3),
                child: InkWell(
                  onTap: () {
                    model.navigateToSignIn();
                  },
                  child: btnHome('Sign in', ThemeColors.background,
                      BrandColors.primary, context),
                ),
              ),
            ],
          ),
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
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(
              SizeConfig.yMargin(context, 5),
            ),
            child: Image(
              height: SizeConfig.yMargin(context, 50),
              width: SizeConfig.xMargin(context, 100),
              image: AssetImage(img1),
              fit: BoxFit.contain,
            ),
          ),
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
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.yMargin(context, 1.3),
      width: SizeConfig.yMargin(context, 1.3),
      decoration: BoxDecoration(
          color: positionIndex == currentIndex
              ? BrandColors.primary
              : ThemeColors.gray.shade800,
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
