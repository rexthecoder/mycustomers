import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:stacked/stacked.dart';
import 'onboarding_viewmodel.dart';
import 'package:flutter_screenutil/size_extension.dart';

// @override
// void initState() {
//   super.initState();
//   Timer.periodic(Duration(seconds: 5), (Timer timer) {
//     if (_currentPage < 2) {
//       _currentPage++;
//     } else {
//       _currentPage = 0;
//     }

//     _pageController.animateToPage(
//       _currentPage,
//       duration: Duration(milliseconds: 350),
//       curve: Curves.easeIn,
//     );
//   });
// }5

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: w, height: h);

    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              PageView(
                onPageChanged: model.onChangedFunction,
                controller: model.pageController,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/onboarding/onboarding1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/onboarding/onboarding2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/onboarding/onboarding3.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: h/2 - 100,
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
                bottom: 50.h,
                              child: InkWell(
                  onTap: () {
                    model.nextFunction();
                  },
                  child: Container(
                    height: 45.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF333CC1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color:
              positionIndex == currentIndex ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
