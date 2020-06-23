import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'package:stacked/stacked.dart';
import 'onboarding_viewmodel.dart';
import 'package:flutter_screenutil/size_extension.dart';

class OnboardingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);

    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: height,
          child: Stack(
          alignment: Alignment.center,
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
                bottom: 350.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    height: 100.h,
                    child: Text(
                      'welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 260,
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
                bottom: 180.h,
                child: Image(
                  height: 40.h,
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'assets/images/onboarding/whitelogo1.png',
                      ),
                    ),
              ),
               Positioned(
                bottom: 140.h,
              
                child: Image(
                  height: 30.h,
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'assets/images/onboarding/whitelogo2.png',
                      ),
                    ),
              ),
              Positioned(
                bottom: 40.h,
                child: InkWell(
                  onTap: () {
                    model.nextFunction();
                  },
                  child: Container(
                    height: 50.h,
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
            
              Positioned(
                bottom: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    InkWell(
                      onTap: () {
                        model.nextFunction();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 18.sp,
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
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
