import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                PageView(
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
                      size: SizeConfig.yMargin(context, 0.8),
                      shape: DotShape.Circle,
                      spacing: SizeConfig.xMargin(context, 3),
                    ),
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.yMargin(context, 12),
                  child: CustomRaisedButton(
                    txtColor: ThemeColors.background,
                    btnColor: BrandColors.primary,
                    btnText: 'Get started',
                    borderColor: BrandColors.primary,
                    child: Container(),
                    onPressed: () {
                      model.navigateToSignUp();
                    },
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.yMargin(context, 5),
                  child: CustomRaisedButton(
                    txtColor: BrandColors.primary,
                    btnColor: ThemeColors.background,
                    btnText: 'Sign in',
                    borderColor: BrandColors.primary,
                    child: Container(),
                    onPressed: () {
                      model.navigateToSignIn();
                    },
                  ),
                ),
              ],
            ),
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
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30.0),
          child: ClipRect(
            child: Image(
              height: SizeConfig.yMargin(context, 50),
              image: AssetImage(img1),
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.yMargin(context, 3)),
        Text(
          txt1,
          style: TextStyle(
            fontSize: SizeConfig.textSize(context, 5),
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: SizeConfig.yMargin(context, 1.2)),
        Text(
          txt2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.textSize(context, 4),
          ),
          softWrap: true,
        ),
      ],
    );
  }
}
