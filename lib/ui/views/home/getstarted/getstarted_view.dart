import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:stacked/stacked.dart';
import 'getstarted_viewmodel.dart';

class GetStartedView extends StatelessWidget {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<GetStartedViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              PageView(
                physics: ClampingScrollPhysics(),
                onPageChanged: model.onChangedFunction,
                controller: _pageController,
                children: [
                  _pages('assets/images/onboarding/onboarding1.png'),
                  _pages('assets/images/onboarding/onboarding2.png'),
                  _pages('assets/images/onboarding/onboarding3.png'),
                ],
              ),
              // Positioned(
              //   bottom: SizeConfig.yMargin(context, 55),
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: SizeConfig.yMargin(context, 5)),
              //     child: Container(
              //       height: SizeConfig.yMargin(context, 10),
              //       child: Text(
              //         'Welcome',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: SizeConfig.yMargin(context, 6),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: SizeConfig.yMargin(context, 40),
                // left: 150.h,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Indicator(
                      positionIndex: 0,
                      currentIndex: model.currentIndex,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Indicator(
                      positionIndex: 1,
                      currentIndex: model.currentIndex,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Indicator(
                      positionIndex: 2,
                      currentIndex: model.currentIndex,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: SizeConfig.yMargin(context, 22),
                child: Image(
                  height: SizeConfig.yMargin(context, 10),
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/onboarding/whitelogo1.png',
                  ),
                ),
              ),
              Positioned(
                bottom: SizeConfig.yMargin(context, 15),
                child: Image(
                  height: SizeConfig.yMargin(context, 5),
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/onboarding/whitelogo2.png',
                  ),
                ),
              ),
              Positioned(
                bottom: SizeConfig.yMargin(context, 5),
                child: InkWell(
                    onTap: () {
                      model.navigateToNextScreen();
                    },
                    child: btnHome('Get Started', context)),
              ),
              Positioned(
                bottom: SizeConfig.yMargin(context, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.yMargin(context, 2),
                      ),
                    ),
                    SizedBox(width: SizeConfig.xMargin(context, 1)),
                    InkWell(
                      onTap: () {
                        model.navigateToLogin();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: SizeConfig.yMargin(context, 2),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => GetStartedViewModel(),
    );
  }

  Widget _pages(image) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
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
      height: SizeConfig.yMargin(context, 1.5),
      width: SizeConfig.xMargin(context, 3),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color:
              positionIndex == currentIndex ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 20))),
    );
  }
}
