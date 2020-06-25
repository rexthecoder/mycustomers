import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

import 'package:stacked/stacked.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  SizeConfig config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<OnboardingViewModel>.nonReactive(
      builder: (context, model, child) => Material(
        child: Container(
          child: Stack(
            children: <Widget>[
              PageView(
                physics: ClampingScrollPhysics(),
                onPageChanged: model.onChangedFunction,
                // controller: model.pageController,
                children: <Widget>[
                  Imagepages(
                    image: 'assets/images/onboarding/ob1.png',
                  ),
                  Imagepages(
                    // height: height,
                    image: 'assets/images/onboarding/ob2.png',
                  ),
                  Imagepages(
                    // height: height,
                    image: 'assets/images/onboarding/ob3.png',
                  ),
                ],
              ),
              Positioned(
                top: config.yMargin(context, 7),
                right: config.yMargin(context, 6),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: config.xMargin(context, 5),
                  ),
                ),
              ),
              Positioned(
                bottom: config.yMargin(context, 57),
                left: config.xMargin(context, 45),
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
              Container(
                margin: EdgeInsets.only(top: config.yMargin(context, 50)),
                height: height * 0.8,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height * 0.05),
                    topRight: Radius.circular(height * 0.05),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: config.yMargin(context, 7)),
                    Text(
                      'Invoice Reminders',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: config.yMargin(context, 5),
                      ),
                    ),
                    SizedBox(height: config.yMargin(context, 3)),
                    Text(
                      'Send overdue invoice reminders to \n customers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: config.yMargin(context, 2.3),
                      ),
                    ),
                    SizedBox(height: config.yMargin(context, 16)),
                    InkWell(
                        onTap: () {
                          //TODO: Next Page View

                          // Using this for testing, clear to work on this page
                          model.navigateToNext();
                        },
                        child: btnHome('Next', context)),
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

class Imagepages extends StatelessWidget {
  final String image;
  const Imagepages({
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.8,
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
